import 'package:flutter_chat_app/modules/change_profile/change_profile_view.dart';
import 'package:flutter_chat_app/modules/contacts/contacts_view.dart';
import 'package:flutter_chat_app/modules/profile/profile_view.dart';
import 'package:flutter_chat_app/modules/update_status/update_status_view.dart';
import 'package:flutter_chat_app/view/message_home_page.dart';
import 'package:flutter_chat_app/view/message_page.dart';
import 'package:get/get.dart';

part 'routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.MESSAGE_HOME_PAGE,
      page: () => MessageHomePage(),
    ),
    GetPage(
      name: _Paths.MESSAGE_PAGE,
      page: () => const MessagePage(),
    ),
    GetPage(
      name: _Paths.MESSAGE_CONTACTS,
      page: () => MessageContacts(),
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: _Paths.UPDATE_STATUS_VIEW,
      page: () => const UpdateStatusView(),
    ),
    GetPage(
      name: _Paths.CHANGE_PROFILE_VIEW,
      page: () => const ChangeProfileView(),
    ),
  ];
}
