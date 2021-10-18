import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/profile/profile_controller.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              _auth.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: deviceSize.height / 75),
            CircleAvatar(
              child: Image.asset("assets/images/noimage.png"),
              backgroundColor: Colors.grey,
              radius: 100,
            ),
            SizedBox(height: deviceSize.height / 75),
            Text(
              "Lorem Ipsum",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: deviceSize.height / 75),
            Text(
              "lorem.ipsum@gmail.com",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: deviceSize.height / 75),
            buildCard(
              "Update Status",
              () {},
              context,
              Icon(Icons.update),
            ),
            buildCard(
              "Change Profile",
              () {},
              context,
              Icon(Icons.person),
            ),
            buildCard(
              "Change Theme",
              () {},
              context,
              Icon(Icons.palette),
            ),
            SizedBox(height: deviceSize.height / 10),
            Text("Chat App v.1.0"),
          ],
        ),
      ),
    );
  }

  Card buildCard(
      String name, VoidCallback function, BuildContext context, Icon icon) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: icon,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          IconButton(
            padding: EdgeInsets.only(bottom: 10),
            icon: Icon(
              Icons.arrow_right,
              size: 50,
            ),
            onPressed: function,
          ),
        ],
      ),
    );
  }
}
