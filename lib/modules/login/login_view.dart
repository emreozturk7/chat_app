import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/modules/login/login_controller.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());
  final authCtrl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Google View',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          reverse: true,
          shrinkWrap: true,
          padding: EdgeInsets.all(32),
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              child: const Text(
                'GOOGLE SIGN IN',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onPressed: () => authCtrl.login(),
            ),
          ].reversed.toList(),
        ),
      ),
    );
  }
}
