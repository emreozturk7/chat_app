import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageController extends GetxController {
  var isShowEmoji = false.obs;
  int total_unread = 0;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late FocusNode focusNode;
  late TextEditingController chatCtrl;
  late ScrollController scroolCtrl;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamChats(String chatId) {
    CollectionReference chats = firestore.collection('chats');

    return chats.doc(chatId).collection('chat').orderBy('time').snapshots();
  }

  Stream<DocumentSnapshot<Object?>> streamFriendData(String friendEmail) {
    CollectionReference users = firestore.collection('users');

    return users.doc(friendEmail).snapshots();
  }

  void addEmojiToChat(Emoji emoji) {
    chatCtrl.text = chatCtrl.text + emoji.emoji;
  }

  void deleteEmoji() {
    chatCtrl.text = chatCtrl.text.substring(0, chatCtrl.text.length - 2);
  }

  void newChat(String email, Map<String, dynamic> argument, String chat) async {
    final key = Key.fromUtf8('32kelimeuzunlugundabirkeykeykeyk');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(chat, iv: iv);

    print('Şifrelenmiş: ' + encrypted.base64);

    if (chat != '') {
      CollectionReference chats = firestore.collection('chats');
      CollectionReference users = firestore.collection('users');

      String date = DateTime.now().toIso8601String();

      await chats.doc(argument['chat_id']).collection('chat').add({
        'sender': email,
        'receiver': argument['friendEmail'],
        'message': encrypted.base64,
        'time': date,
        'isRead': false,
        'groupTime': DateFormat.yMMMd('en_US').format(DateTime.parse(date)),
      });

      Timer(
        Duration.zero,
        () => scroolCtrl.jumpTo(scroolCtrl.position.maxScrollExtent),
      );

      chatCtrl.clear();

      await users
          .doc(email)
          .collection('chats')
          .doc(argument['chat_id'])
          .update({
        'lastTime': date,
      });
      final chechkChatsFriend = await users
          .doc(argument['friendEmail'])
          .collection('chats')
          .doc(argument['chat_id'])
          .get();

      if (chechkChatsFriend.exists) {
        final checkTotalUnread = await chats
            .doc(argument['chat_id'])
            .collection('chat')
            .where('isRead', isEqualTo: false)
            .where('sender', isEqualTo: email)
            .get();

        total_unread = checkTotalUnread.docs.length;

        await users
            .doc(argument['friendEmail'])
            .collection('chats')
            .doc(argument['chat_id'])
            .update({'lastTime': date, 'total_unread': total_unread});
      } else {
        await users
            .doc(argument['friendEmail'])
            .collection('chats')
            .doc(argument['chat_id'])
            .set({
          'connection': email,
          'lastTime': date,
          'total_unread': 1,
        });
      }
    }
  }

  @override
  void onInit() {
    chatCtrl = TextEditingController();
    scroolCtrl = ScrollController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    chatCtrl.dispose();
    scroolCtrl.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
