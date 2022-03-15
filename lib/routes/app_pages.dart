import 'package:flutter_chat_app/modules/change_profile/change_profile_view.dart';
import 'package:flutter_chat_app/modules/contacts/contacts_view.dart';
import 'package:flutter_chat_app/modules/introduction/introduction_view.dart';
import 'package:flutter_chat_app/modules/login/login_view.dart';
import 'package:flutter_chat_app/modules/message/message_view.dart';
import 'package:flutter_chat_app/modules/profile/profile_view.dart';
import 'package:flutter_chat_app/modules/tracking/tracking_view.dart';
import 'package:flutter_chat_app/modules/update_status/update_status_view.dart';
import 'package:flutter_chat_app/modules/home/home_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME_VIEW,
      page: () => HomeView(),
    ),
    GetPage(
      name: _Paths.MESSAGE_VIEW,
      page: () => MessageView(),
    ),
    GetPage(
      name: _Paths.CONTACTS_VIEW,
      page: () => ContactsView(),
    ),
    GetPage(
      name: _Paths.PROFILE_VIEW,
      page: () => ProfileView(),
    ),
    GetPage(
      name: _Paths.UPDATE_STATUS_VIEW,
      page: () => UpdateStatusView(),
    ),
    GetPage(
      name: _Paths.CHANGE_PROFILE_VIEW,
      page: () => ChangeProfileView(),
    ),
    GetPage(
      name: _Paths.LOGIN_VIEW,
      page: () => LoginView(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION_VIEW,
      page: () => IntroductionView(),
    ),
    GetPage(
      name: _Paths.TRACKING_VIEW,
      page: () => TrackingView(),
    ),
  ];
}
