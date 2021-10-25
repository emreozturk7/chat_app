part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME_VIEW = _Paths.HOME_VIEW;
  static const MESSAGE_VIEW = _Paths.MESSAGE_VIEW;
  static const CONTACTS_VIEW = _Paths.CONTACTS_VIEW;
  static const PROFILE_VIEW = _Paths.PROFILE_VIEW;
  static const UPDATE_STATUS_VIEW = _Paths.UPDATE_STATUS_VIEW;
  static const CHANGE_PROFILE_VIEW = _Paths.CHANGE_PROFILE_VIEW;
  static const LOGIN_VIEW = _Paths.LOGIN_VIEW;
  static const INTRODUCTION_VIEW = _Paths.INTRODUCTION_VIEW;
}

abstract class _Paths {
  static const HOME_VIEW = '/home_view';
  static const MESSAGE_VIEW = '/message_view';
  static const CONTACTS_VIEW = '/contacts_view';
  static const PROFILE_VIEW = '/profile_view';
  static const UPDATE_STATUS_VIEW = '/update_status_view';
  static const CHANGE_PROFILE_VIEW = '/change_profile_view';
  static const LOGIN_VIEW = '/login_view';
  static const INTRODUCTION_VIEW = '/introduction_view';
}
