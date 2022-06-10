import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/modules/home/home_controller.dart';
import 'package:flutter_chat_app/modules/meets/meet_view.dart';
import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final authC = Get.find<AuthController>();
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            elevation: 5,
            child: Container(
              margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black38,
                  ),
                ),
              ),
              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: IconButton(
                      onPressed: () {
                        Get.to(MeetView());
                      },
                      icon: Icon(Icons.ac_unit),
                    ),
                  ),
                  Spacer(flex: 4),
                  Expanded(
                    flex: 40,
                    child: Text(
                      'Görüşmeler',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _controller.chatStream(authC.user.value.email!),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.active) {
                  var listDocsChats = snapshot1.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: listDocsChats.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<
                          DocumentSnapshot<Map<String, dynamic>>>(
                        stream: _controller
                            .friendStream(listDocsChats[index]["connection"]),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.active) {
                            var data = snapshot2.data!.data();
                            return data!["status"] == ""
                                ? ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 5,
                                    ),
                                    onTap: () => _controller.goToMessage(
                                      listDocsChats[index].id,
                                      authC.user.value.email!,
                                      listDocsChats[index]["connection"],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: data["photoUrl"] == "noimage"
                                            ? Image.asset(
                                                "assets/logo/noimage.png",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                "${data["photoUrl"]}",
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    title: Text(
                                      "${data["name"]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: listDocsChats[index]
                                                ["total_unread"] ==
                                            0
                                        ? SizedBox()
                                        : Chip(
                                            backgroundColor: Colors.red[900],
                                            label: Text(
                                              "${listDocsChats[index]["total_unread"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                  )
                                : ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 5,
                                    ),
                                    onTap: () => _controller.goToMessage(
                                      listDocsChats[index].id,
                                      authC.user.value.email!,
                                      listDocsChats[index]["connection"],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: data["photoUrl"] == "noimage"
                                            ? Image.asset(
                                                "assets/logo/noimage.png",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                "${data["photoUrl"]}",
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    title: Text(
                                      "${data["name"]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: listDocsChats[index]
                                                ["total_unread"] ==
                                            0
                                        ? SizedBox()
                                        : Chip(
                                            backgroundColor: Colors.red[900],
                                            label: Text(
                                              "${listDocsChats[index]["total_unread"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                  );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.DATE_VIEW),
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}
