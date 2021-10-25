import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/modules/google/google_controller.dart';
import 'package:get/get.dart';

class GoogleView extends StatelessWidget {
  final GoogleController _controller = Get.put(GoogleController());
  final authCtrl = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google View'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              child: const Text('Google Sign In'),
              onPressed: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
