abstract class MobileLoginState {}

class InitState extends MobileLoginState {
  InitState();
}

class Loading extends MobileLoginState {
  Loading();
}

class Error extends MobileLoginState {
  final String error;

  Error(this.error);
}

class RedirectToOtpPage extends MobileLoginState {
  final String mobile;

  RedirectToOtpPage(this.mobile);
}
