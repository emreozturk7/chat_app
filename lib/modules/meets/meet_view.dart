import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/modules/contacts/contacts_controller.dart';
import 'package:get/get.dart';

class MeetView extends StatelessWidget {
  final authC = Get.find<AuthController>();
  final ContactsController _controller = Get.put(ContactsController());

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
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Spacer(flex: 2),
                  Expanded(
                    flex: 10,
                    child: Text(
                      'Buluşmalar',
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(authC.user.value.email)
                  .collection('meet')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    padding: EdgeInsets.zero,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black38,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                  data["receiverPhotoUrl"],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${data['receiverName']}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${data['date']}',
                                  ),
                                  Text(
                                    '${data['hour']}',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: data['status'].toString() == "Waiting"
                                  ? Row(
                                      children: [
                                        InkWell(
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 35,
                                          ),
                                          onTap: () {},
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 35,
                                          ),
                                          onTap: () {},
                                        ),
                                      ],
                                    )
                                  : data['status'].toString() == "Accepted"
                                      ? Text(
                                          'Kabul edildi',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Text(
                                          'Reddedildi',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
