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
            title: 'Arkadaş takip',
            body: 'Sayfa 1',
            image: SizedBox(
              width: Get.width * 0.6,
              height: Get.height * 0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/empty.json'),
              ),
            ),
          ),
          PageViewModel(
            title: 'Arkadaş takip',
            body: 'Sayfa 2',
            image: SizedBox(
              width: Get.width * 0.6,
              height: Get.height * 0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/empty.json'),
              ),
            ),
          ),
          PageViewModel(
            title: 'Arkadaş takip',
            body: 'Sayfa 3',
            image: SizedBox(
              width: Get.width * 0.6,
              height: Get.height * 0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/empty.json'),
              ),
            ),
          ),
          PageViewModel(
            title: 'Arkadaş takip',
            body: 'Sayfa 4',
            image: SizedBox(
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
        skip: Text('Atla'),
        next: Text(
          'İleri',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        done: Text(
          'Giriş',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
