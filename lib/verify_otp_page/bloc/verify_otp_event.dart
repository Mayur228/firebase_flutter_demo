import 'package:firebase_auth/firebase_auth.dart';

abstract class VerifyOtpEvent {}

class GetOtp extends VerifyOtpEvent {
  final String mobile;

  GetOtp(this.mobile);
}

class VerifyOtp extends VerifyOtpEvent {
  final String otpCode;
  final String verificationId;

  VerifyOtp(this.otpCode, this.verificationId);
}

class OtpSent extends VerifyOtpEvent {
  final String verificationId;
  final int? token;

  OtpSent(this.verificationId, this.token);
}

class AuthErrorEvent extends VerifyOtpEvent {
  final String error;

  AuthErrorEvent(this.error);
}

class AuthVerificationCompleteEvent extends VerifyOtpEvent {
  final PhoneAuthCredential credential;

  AuthVerificationCompleteEvent(this.credential);
}
