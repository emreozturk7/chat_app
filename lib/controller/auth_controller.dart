import 'package:flutter_chat_app/model/users_model.dart';
import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
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

  Future<void> googleSignInAndRegister() async {
    try {
      await _googleSignIn.signOut();

      await _googleSignIn.signIn().then((value) => _currentUser = value);

      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        await _auth
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        isAuth.value = true;
        Get.offAllNamed(Routes.HOME_VIEW);
      } else {}
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN_VIEW);
  }

  void changeProfile(String name, String status) {}

  void updateStatus(String status) {}

  void updatePhotoUrl(String url) async {}

  void addNewConnection(String friendEmail) async {}
}
