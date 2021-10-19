part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const MESSAGE_HOME_PAGE = _Paths.MESSAGE_HOME_PAGE;
  static const MESSAGE_PAGE = _Paths.MESSAGE_PAGE;
  static const MESSAGE_CONTACTS = _Paths.MESSAGE_CONTACTS;
  static const PROFILE_SCREEN = _Paths.PROFILE_SCREEN;
  static const UPDATE_STATUS_VIEW = _Paths.UPDATE_STATUS_VIEW;
  static const CHANGE_PROFILE_VIEW = _Paths.CHANGE_PROFILE_VIEW;
}

abstract class _Paths {
  static const MESSAGE_HOME_PAGE = '/message_home_page';
  static const MESSAGE_PAGE = '/message_page';
  static const MESSAGE_CONTACTS = '/message_contacts';
  static const PROFILE_SCREEN = '/profile_view';
  static const UPDATE_STATUS_VIEW = '/update_status_view';
  static const CHANGE_PROFILE_VIEW = '/change_profile_view';
}
