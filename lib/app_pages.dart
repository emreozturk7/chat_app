import 'package:flutter_chat_app/view/message_contacts.dart';
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
      page: () => const MessageContacts(),
    ),
  ];
}
