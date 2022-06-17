import 'package:flutter_chat_app/model/users_model.dart';
import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  }

  Future<bool> autoLogin() async {
    print(user);
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

        final checkUser = await users.doc(_currentUser!.email).get();

        if (checkUser.data() == null) {
          await users.doc(_currentUser!.email).set({
            'uid': userCredential!.user!.uid,
            'name': _currentUser!.displayName,
            'keyName': _currentUser!.displayName!.substring(0, 1).toUpperCase(),
            'email': _currentUser!.email,
            'photoUrl': _currentUser!.photoUrl ?? 'noimage',
            'creationTime':
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            'lastSignInTime': userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            'updatedTime': DateTime.now().toIso8601String(),
          });
          users.doc(_currentUser!.email).collection('chats');
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

          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;

            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              total_unread: dataDocChat['total_unread'],
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

  void addNewConnection(String friendEmail) async {
    bool flagNewConnection = false;
    var chatID;
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

        chatID = checkConnection.docs[0].id;
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
          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              total_unread: dataDocChat['total_unread'],
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
        chatID = chatDataId;

        user.refresh();
      } else {
        final newChatDoc = await chats.add({
          'connections': [
            _currentUser!.email,
            friendEmail,
          ],
        });

        chats.doc(newChatDoc.id).collection('chat');

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
          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;

            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              total_unread: dataDocChat['total_unread'],
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

        chatID = newChatDoc.id;

        user.refresh();
      }
    }

    final updateStatusChat = await chats
        .doc(chatID)
        .collection('chat')
        .where('isRead', isEqualTo: false)
        .where('receiver', isEqualTo: _currentUser!.email)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chatID)
          .collection('chat')
          .doc(element.id)
          .update({'isRead': true});
    });
    await users
        .doc(_currentUser!.email)
        .collection('chats')
        .doc(chatID)
        .update({'total_unread': 0});
    Get.toNamed(
      Routes.MESSAGE_VIEW,
      arguments: {
        'chat_id': '$chatID',
        'friendEmail': friendEmail,
      },
    );
  }
}
