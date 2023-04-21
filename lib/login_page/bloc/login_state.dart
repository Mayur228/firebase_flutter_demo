import 'package:firebase_demo_flutter/login_page/model/user_data.dart';

abstract class LoginState {}

class Success extends LoginState {
  final UserData userData;

  Success(this.userData);
}

class Failed extends LoginState {
  Failed();
}

class NoDataSet extends LoginState {

}

class Loading extends LoginState {
  Loading();
}

class RedirectionState extends LoginState {
  final UserData userData;
  RedirectionState(this.userData);
}

class RedirectToMobileState extends LoginState {
  RedirectToMobileState();
}
