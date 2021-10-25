import 'package:flutter_chat_app/model/users_model.dart';
import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;

  var user = UsersModel().obs;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> firstInitialized() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
  }

  Future<bool> skipIntro() async {
    return true;
  }

  Future<bool> autoLogin() async {
    return true;
  }

  Future<void> login() async {
    //Get.offAllNamed(Routes.HOME_VIEW);
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    Get.offAllNamed(Routes.GOOGLE_VIEW);
  }

  void changeProfile(String name, String status) {}

  void updateStatus(String status) {}

  void updatePhotoUrl(String url) async {}

  void addNewConnection(String friendEmail) async {}
}
