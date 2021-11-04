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
            SizedBox(
              width: deviceSize.width / 3,
              height: deviceSize.height / 4,
              child: Image.asset('assets/images/chat.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 30,
              ),
              child: SizedBox(
                height: deviceSize.height / 10,
                width: deviceSize.width / 1.5,
                child: TextField(
                  controller: _controller.emailCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: SizedBox(
                height: deviceSize.height / 10,
                width: deviceSize.width / 1.5,
                child: TextField(
                  controller: _controller.passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.ten_k_rounded),
              label: Text(
                'SIGN IN',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              onPressed: () => _controller.signIn(),
            ),
            SizedBox(height: 7.5),
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
