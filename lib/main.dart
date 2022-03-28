import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:flutter_chat_app/utils/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(Main());
}

class Main extends StatelessWidget {
  final authCtrl = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        Duration(seconds: 0),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Arkadaş Takip',
              initialRoute:
                  authCtrl.isAuth.isTrue ? Routes.HOME_VIEW : Routes.LOGIN_VIEW,
              getPages: AppPages.routes,
            ),
          );
        }
        return FutureBuilder(
          future: authCtrl.firstInitialized(),
          builder: (context, snapshot) => SplashScreen(),
        );
      },
    );
  }
}
