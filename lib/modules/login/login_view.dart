import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_chat_app/core/context_extensions.dart';

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
        child: Padding(
          padding: context.paddingMedium,
          child: Column(
            children: [
              Expanded(
                flex: 14,
                child: Center(
                  child: SizedBox(
                    child: Lottie.asset("assets/lottie/date.json"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(context.mediumValue),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          child: Image.asset('assets/images/googlesignin.png'),
                        ),
                        SizedBox(width: context.mediumValue),
                        Text(
                          'Google ile giriş yap',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => authCtrl.login(),
                ),
              ),
              Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
