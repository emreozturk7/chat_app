import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/modules/message/item_chat.dart';
import 'package:flutter_chat_app/modules/message/message_controller.dart';
import 'package:flutter_chat_app/modules/tracking/tracking_view.dart';
import 'package:get/get.dart';

class MessageView extends StatelessWidget {
  final authC = Get.find<AuthController>();
  final MessageController _controller = Get.put(MessageController());
  final String chatID = (Get.arguments as Map<String, dynamic>)["chat_id"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackingView(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.red[900],
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5),
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: StreamBuilder<DocumentSnapshot<Object?>>(
                  stream: _controller.streamFriendData(
                      (Get.arguments as Map<String, dynamic>)["friendEmail"]),
                  builder: (context, snapFriendUser) {
                    if (snapFriendUser.connectionState ==
                        ConnectionState.active) {
                      var dataFriend =
                          snapFriendUser.data!.data() as Map<String, dynamic>;

                      if (dataFriend["photoUrl"] == "noimage") {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/noimage.png",
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            dataFriend["photoUrl"],
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/noimage.png",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        title: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: _controller.streamFriendData(
              (Get.arguments as Map<String, dynamic>)["friendEmail"]),
          builder: (context, snapFriendUser) {
            if (snapFriendUser.connectionState == ConnectionState.active) {
              var dataFriend =
                  snapFriendUser.data!.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    dataFriend["name"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          },
        ),
        centerTitle: false,
      ),
      body: WillPopScope(
        onWillPop: () {
          if (_controller.isShowEmoji.isTrue) {
            _controller.isShowEmoji.value = false;
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _controller.streamChats(chatID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var allData = snapshot.data!.docs;

                    Timer(
                      Duration.zero,
                      () => _controller.scroolCtrl.jumpTo(
                          _controller.scroolCtrl.position.maxScrollExtent),
                    );
                    return ListView.builder(
                      controller: _controller.scroolCtrl,
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        String gelenMesaj = "${allData[index]["message"]}";
                        final key =
                            Key.fromUtf8('f8S99f677dSf426SDsage2uU4Df25gDs');
                        final iv = IV.fromLength(16);

                        final encrypter = Encrypter(AES(key));

                        var decrypted = encrypter.decrypt64(gelenMesaj, iv: iv);

                        if (index == 0) {
                          return Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "${allData[index]["groupTime"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ItemChat(
                                message: decrypted,
                                isSender: allData[index]["sender"] ==
                                        authC.user.value.email!
                                    ? true
                                    : false,
                                time: "${allData[index]["time"]}",
                              ),
                            ],
                          );
                        } else {
                          if (allData[index]["groupTime"] ==
                              allData[index - 1]["groupTime"]) {
                            return ItemChat(
                              message: decrypted,
                              isSender: allData[index]["sender"] ==
                                      authC.user.value.email!
                                  ? true
                                  : false,
                              time: "${allData[index]["time"]}",
                            );
                          } else {
                            return Column(
                              children: [
                                Text(
                                  "${allData[index]["groupTime"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ItemChat(
                                  message: decrypted,
                                  isSender: allData[index]["sender"] ==
                                          authC.user.value.email!
                                      ? true
                                      : false,
                                  time: "${allData[index]["time"]}",
                                ),
                              ],
                            );
                          }
                        }
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: _controller.isShowEmoji.isTrue
                    ? 5
                    : context.mediaQueryPadding.bottom,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      autocorrect: false,
                      controller: _controller.chatCtrl,
                      focusNode: _controller.focusNode,
                      onEditingComplete: () => _controller.newChat(
                        authC.user.value.email!,
                        Get.arguments as Map<String, dynamic>,
                        _controller.chatCtrl.text,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            _controller.focusNode.unfocus();
                            _controller.isShowEmoji.toggle();
                          },
                          icon: Icon(Icons.emoji_emotions_outlined),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Material(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red[900],
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => _controller.newChat(
                        authC.user.value.email!,
                        Get.arguments as Map<String, dynamic>,
                        _controller.chatCtrl.text,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => (_controller.isShowEmoji.isTrue)
                  ? SizedBox(
                      height: 325,
                      child: EmojiPicker(
                        onEmojiSelected: (category, emoji) {
                          _controller.addEmojiToChat(emoji);
                        },
                        onBackspacePressed: () {
                          _controller.deleteEmoji();
                        },
                        config: Config(
                          backspaceColor: Color(0xFFB71C1C),
                          columns: 7,
                          emojiSizeMax: 32.0,
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          initCategory: Category.RECENT,
                          bgColor: Color(0xFFF2F2F2),
                          indicatorColor: Color(0xFFB71C1C),
                          iconColor: Colors.grey,
                          iconColorSelected: Color(0xFFB71C1C),
                          progressIndicatorColor: Color(0xFFB71C1C),
                          showRecentsTab: true,
                          recentsLimit: 28,
                          noRecentsText: "No Recent",
                          noRecentsStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black26,
                          ),
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL,
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
