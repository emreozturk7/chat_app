import 'package:flutter_chat_app/model/users_model.dart';
import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;

  var user = UsersModel().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> firstInitialized() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });

    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
  }

  Future<bool> skipIntro() async {
    final box = GetStorage();
    if (box.read('skipIntro') != null || box.read('skipIntro') == true) {
      return true;
    }
    return true;
  }

  Future<bool> autoLogin() async {
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        await _googleSignIn
            .signInSilently()
            .then((value) => _currentUser = value);
        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await _auth
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        CollectionReference users = firestore.collection('users');

        await users.doc(_currentUser!.email).update({
          'lastSignInTime':
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        user(UsersModel.fromJson(currUserData));

        user.refresh();

        final listChats =
            await users.doc(_currentUser!.email).collection('chats').get();

        if (listChats.docs.isNotEmpty) {
          List<ChatUser> dataListChats = [];
          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              total_unread: dataDocChat['local_unread'],
            ));
          }
          user.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          user.update((user) {
            user!.chats = [];
          });
        }
        user.refresh();

        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<void> login() async {
    try {
      await _googleSignIn.signOut();

      await _googleSignIn.signIn().then((value) => _currentUser = value);

      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        await _auth
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        final box = GetStorage();
        if (box.read('skipIntro') != null) {
          box.remove('skipIntro');
        }
        box.write('skipIntro', true);

        CollectionReference users = firestore.collection('users');

        final checkuser = await users.doc(_currentUser!.email).get();

        if (checkuser.data() == null) {
          await users.doc(_currentUser!.email).set({
            'uid': userCredential!.user!.uid,
            'name': _currentUser!.displayName,
            'keyName': _currentUser!.displayName!.substring(0, 1).toUpperCase(),
            'email': _currentUser!.email,
            'photoUrl': _currentUser!.photoUrl ?? 'noimage',
            'status': '',
            'creationTime':
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            'lastSignInTime': userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            'updatedTime': DateTime.now().toIso8601String(),
          });
          await users.doc(_currentUser!.email).collection('chats');
        } else {
          await users.doc(_currentUser!.email).update({
            'lastSignInTime': userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        user(UsersModel.fromJson(currUserData));

        user.refresh();

        final listChats =
            await users.doc(_currentUser!.email).collection('chats').get();

        if (listChats.docs.isNotEmpty) {
          List<ChatUser> dataListChats = [];

          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;

            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              total_unread: dataDocChat['total_unread'],
            ));
          });
          user.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          user.update((user) {
            user!.chats = [];
          });
        }
        user.refresh();

        isAuth.value = true;
        Get.offAllNamed(Routes.HOME_VIEW);
      } else {}
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN_VIEW);
  }

  void changeProfile(String name, String status) {
    String date = DateTime.now().toIso8601String();

    CollectionReference users = firestore.collection('users');

    users.doc(_currentUser!.email).update({
      'name': name,
      'keyName': name.substring(0, 1).toUpperCase(),
      'status': status,
      'lastSignInTime':
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      'updatedTime': date,
    });

    user.update((user) {
      user!.name = name;
      user.keyName = name.substring(0, 1).toUpperCase();
      user.status = status;
      user.lastSignInTime =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedTime = date;
    });

    user.refresh();

    Get.defaultDialog(title: 'Success', middleText: 'Change Profile Success');
  }

  void updateStatus(String status) {
    String date = DateTime.now().toIso8601String();

    CollectionReference users = firestore.collection('users');

    users.doc(_currentUser!.email).update({
      'status': status,
      'lastSignInTime':
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      'updatedTime': date,
    });

    user.update((user) {
      user!.status = status;
      user.lastSignInTime =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedTime = date;
    });

    user.refresh();

    Get.defaultDialog(title: 'Success', middleText: 'Update Status Success');
  }

  void updatePhotoUrl(String url) async {
    String date = DateTime.now().toIso8601String();

    CollectionReference users = firestore.collection('users');

    await users.doc(_currentUser!.email).update({
      'photoUrl': url,
      'updatedTime': date,
    });

    user.update((user) {
      user!.photoUrl = url;
      user.updatedTime = date;
    });

    user.refresh();
    Get.defaultDialog(
        title: 'Success', middleText: 'Change Photo Profile Success');
  }

  void addNewConnection(String friendEmail) async {
    bool flagNewConnection = false;
    var chat_id;
    String date = DateTime.now().toIso8601String();
    CollectionReference chats = firestore.collection('chats');
    CollectionReference users = firestore.collection('users');

    final docChats =
        await users.doc(_currentUser!.email).collection('chats').get();

    if (docChats.docs.isNotEmpty) {
      final checkConnection = await users
          .doc(_currentUser!.email)
          .collection('chats')
          .where('connection', isEqualTo: friendEmail)
          .get();

      if (checkConnection.docs.isNotEmpty) {
        flagNewConnection = false;

        chat_id = checkConnection.docs[0].id;
      } else {
        flagNewConnection = true;
      }
    } else {
      flagNewConnection = true;
    }
    if (flagNewConnection) {
      final chatsDocs = await chats.where(
        'connections',
        whereIn: [
          [
            _currentUser!.email,
            friendEmail,
          ],
          [
            friendEmail,
            _currentUser!.email,
          ],
        ],
      ).get();
      if (chatsDocs.docs.isNotEmpty) {
        final chatDataId = chatsDocs.docs[0].id;
        final chatsData = chatsDocs.docs[0].data() as Map<String, dynamic>;

        await users
            .doc(_currentUser!.email)
            .collection('chats')
            .doc(chatDataId)
            .set({
          'connection': friendEmail,
          'lastTime': chatsData['lastTime'],
          'total_unread': 0,
        });

        final listChats =
            await users.doc(_currentUser!.email).collection('chats').get();

        if (listChats.docs.isEmpty) {
          List<ChatUser> dataListChats = List<ChatUser>.empty();
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              total_unread: dataDocChat['total_unread'],
            ));
          });
          user.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          user.update((user) {
            user!.chats = [];
          });
        }
        chat_id = chatDataId;

        user.refresh();
      } else {
        final newChatDoc = await chats.add({
          'connections': [
            _currentUser!.email,
            friendEmail,
          ],
        });

        await chats.doc(newChatDoc.id).collection('chat');

        await users
            .doc(_currentUser!.email)
            .collection('chats')
            .doc(newChatDoc.id)
            .set({
          'connection': friendEmail,
          'lastTime': date,
          'total_unread': 0,
        });

        final listChats =
            await users.doc(_currentUser!.email).collection('chats').get();

        if (listChats.docs.isEmpty) {
          List<ChatUser> dataListChats = List<ChatUser>.empty();
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;

            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              total_unread: dataDocChat['total_unread'],
            ));
          });
          user.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          user.update((user) {
            user!.chats = [];
          });
        }

        chat_id = newChatDoc.id;

        user.refresh();
      }
    }

    final updateStatusChat = await chats
        .doc(chat_id)
        .collection('chat')
        .where('isRead', isEqualTo: false)
        .where('receiver', isEqualTo: _currentUser!.email)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chat_id)
          .collection('chat')
          .doc(element.id)
          .update({'isRead': true});
    });
    await users
        .doc(_currentUser!.email)
        .collection('chats')
        .doc(chat_id)
        .update({'total_unread': 0});
    Get.toNamed(
      Routes.MESSAGE_VIEW,
      arguments: {
        'chat_id': '$chat_id',
        'friendEmail': friendEmail,
      },
    );
  }
}
