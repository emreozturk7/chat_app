part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const MESSAGE_HOME_PAGE = _Paths.MESSAGE_HOME_PAGE;
  static const MESSAGE_PAGE = _Paths.MESSAGE_PAGE;
  static const MESSAGE_CONTACTS = _Paths.MESSAGE_CONTACTS;
}

abstract class _Paths {
  static const MESSAGE_HOME_PAGE = '/message_home_page';
  static const MESSAGE_PAGE = '/message_page';
  static const MESSAGE_CONTACTS = '/message_contacts';
}
