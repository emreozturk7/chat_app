import 'package:flutter_chat_app/modules/contacts/contacts_view.dart';
import 'package:flutter_chat_app/modules/login/login_view.dart';
import 'package:flutter_chat_app/modules/message/message_view.dart';
import 'package:flutter_chat_app/modules/tracking/tracking_view.dart';
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
      name: _Paths.LOGIN_VIEW,
      page: () => LoginView(),
    ),
    GetPage(
      name: _Paths.TRACKING_VIEW,
      page: () => TrackingView(),
    ),
  ];
}
