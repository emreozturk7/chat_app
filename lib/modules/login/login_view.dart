import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final authCtrl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Giriş Yap',
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
                'Google ile giriş yap',
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
