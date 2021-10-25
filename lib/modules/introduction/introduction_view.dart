import 'package:flutter/material.dart';
import 'package:flutter_chat_app/modules/introduction/introduction_controller.dart';
import 'package:get/get.dart';

class IntroductionView extends StatelessWidget {
  final IntroductionController _controller = Get.put(IntroductionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IntroductionView'),
      ),
      body: Center(
        child: Text('IntroductionView'),
      ),
    );
  }
}
