abstract class VerifyOtpState {}

class InitState extends VerifyOtpState {
  InitState();
}

class Loading extends VerifyOtpState {
  Loading();
}

class Error extends VerifyOtpState {
  final String error;

  Error(this.error);
}

class PhoneAuthVerified extends VerifyOtpState {
  PhoneAuthVerified();
}

class PhoneAuthCodeSentSuccess extends VerifyOtpState {
  final String verificationId;

  PhoneAuthCodeSentSuccess(this.verificationId);
}
