import 'package:flutter/material.dart';
import 'package:flutter_chat_app/modules/introduction/introduction_controller.dart';
import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class IntroductionView extends StatelessWidget {
  final IntroductionController _controller = Get.put(IntroductionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Deneme1',
            body: 'DENEME1',
            image: Container(
              width: Get.width * 0.6,
              height: Get.height * 0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/empty.json'),
              ),
            ),
          ),
          PageViewModel(
            title: 'Deneme2',
            body: 'DENEME2',
            image: Container(
              width: Get.width * 0.6,
              height: Get.height * 0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/empty.json'),
              ),
            ),
          ),
          PageViewModel(
            title: 'Deneme3',
            body: 'DENEME3',
            image: Container(
              width: Get.width * 0.6,
              height: Get.height * 0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/empty.json'),
              ),
            ),
          ),
          PageViewModel(
            title: 'Deneme4',
            body: 'DENEME4',
            image: Container(
              width: Get.width * 0.6,
              height: Get.height * 0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/empty.json'),
              ),
            ),
          ),
        ],
        onDone: () => Get.offAllNamed(Routes.LOGIN_VIEW),
        showSkipButton: true,
        skip: Text('Skip'),
        next: Text(
          'Next',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        done: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
