import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> chatStream(String email) {
    return firestore
        .collection('users')
        .doc(email)
        .collection('chats')
        .orderBy('lastTime', descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> friendStream(String email) {
    return firestore.collection('users').doc(email).snapshots();
  }

  void goToMessage(String chat_id, String email, String friendEmail) async {
    CollectionReference chats = firestore.collection('chats');
    CollectionReference users = firestore.collection('users');

    final updateStatusChat = await chats
        .doc(chat_id)
        .collection('chat')
        .where('isRead', isEqualTo: false)
        .where('receiver', isEqualTo: email)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chat_id)
          .collection('chat')
          .doc(element.id)
          .update({'isRead': true});
    });

    await users
        .doc(email)
        .collection('chats')
        .doc(chat_id)
        .update({'total_unread': 0});

    Get.toNamed(
      Routes.MESSAGE_VIEW,
      arguments: {
        'chat_id': chat_id,
        'friendEmail': friendEmail,
      },
    );
  }
}
