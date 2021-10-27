import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/modules/change_profile/change_profile_controller.dart';
import 'package:get/get.dart';

class ChangeProfileView extends StatelessWidget {
  final ChangeProfileController _controller =
      Get.put(ChangeProfileController());
  final authCtrl = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    _controller.emailCtrl.text = authCtrl.user.value.email!;
    _controller.nameCtrl.text = authCtrl.user.value.name!;
    _controller.statusCtrl.text = authCtrl.user.value.status!;
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Change Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(deviceSize.height / 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: deviceSize.height / 15,
                child: Obx(
                  () => ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: authCtrl.user.value.photoUrl! == "noimage"
                        ? Image.asset(
                            "assets/images/noimage.png",
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            authCtrl.user.value.photoUrl!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(height: deviceSize.height / 25),
              TextField(
                controller: _controller.emailCtrl,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
              SizedBox(height: deviceSize.height / 50),
              TextField(
                controller: _controller.nameCtrl,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
              SizedBox(height: deviceSize.height / 50),
              TextField(
                controller: _controller.statusCtrl,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Status',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
              SizedBox(height: deviceSize.height / 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "upload.jpeg",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "chosen..",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: deviceSize.height / 25),
              ElevatedButton(
                child: Text(
                  "UPDATE",
                  style: TextStyle(fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: deviceSize / 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onPressed: () {
                  authCtrl.changeProfile(
                    _controller.nameCtrl.text,
                    _controller.statusCtrl.text,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
