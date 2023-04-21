
import 'package:firebase_demo_flutter/login_page/model/user_data.dart';

abstract class LoginEvent {

}

class GoogleLoginEvent extends LoginEvent {
  GoogleLoginEvent();
}

class RedirectToDetailsPage extends LoginEvent {
  final UserData userData;

  RedirectToDetailsPage(this.userData);

}

class CheckUserSingIn extends LoginEvent {
  CheckUserSingIn();
}

class LoginWithMobile extends LoginEvent {
  LoginWithMobile();
}