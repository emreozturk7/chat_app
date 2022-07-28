part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME_VIEW = _Paths.HOME_VIEW;
  static const MESSAGE_VIEW = _Paths.MESSAGE_VIEW;
  static const CONTACTS_VIEW = _Paths.CONTACTS_VIEW;
  static const LOGIN_VIEW = _Paths.LOGIN_VIEW;
  static const TRACKING_VIEW = _Paths.TRACKING_VIEW;
  static const DATE_VIEW = _Paths.DATE_VIEW;
  static const LOADING_VIEW = _Paths.LOADING_VIEW;
  static const START_CONVERSATION = _Paths.START_CONVERSATION;
  static const MEET_VIEW = _Paths.MEET_VIEW;
}

abstract class _Paths {
  static const HOME_VIEW = '/home_view';
  static const MESSAGE_VIEW = '/message_view';
  static const CONTACTS_VIEW = '/contacts_view';
  static const LOGIN_VIEW = '/login_view';
  static const TRACKING_VIEW = '/tracking_view';
  static const DATE_VIEW = '/date_view';
  static const LOADING_VIEW = '/loading_screen';
  static const START_CONVERSATION = '/start_conversation';
  static const MEET_VIEW = '/meet_view';
}
