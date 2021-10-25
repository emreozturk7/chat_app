import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
              title: 'Chat App',
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.white,
                accentColor: Colors.black,
                buttonColor: Colors.red[900],
              ),
              initialRoute: authCtrl.isSkipIntro.isTrue
                  ? authCtrl.isAuth.isTrue
                      ? Routes.HOME_VIEW
                      : Routes.GOOGLE_VIEW
                  : Routes.INTRODUCTION_VIEW,
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

/*
return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 3),
      ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<MyUser?>.value(
            catchError: (_, __) => null,
            value: AuthService().user,
            initialData: null,
            child: GetMaterialApp(
              routes: {
                '/message_page': (context) => MessageView(),
                '/message_home_page': (context) => HomeView(),
                '/message_contacts': (context) => ContactsView(),
                '/profile_screen': (context) => ProfileView(),
                '/update_status_view': (context) => UpdateStatusView(),
                '/change_profile_view': (context) => ChangeProfileView(),
              },
              home: const Wrapper(),
            ),
          );
        }
        return const SplashScreen();
      },
    );
 */
