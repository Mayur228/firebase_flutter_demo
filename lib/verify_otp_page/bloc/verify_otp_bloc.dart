import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_flutter/verify_otp_page/bloc/verify_otp_event.dart';
import 'package:firebase_demo_flutter/verify_otp_page/bloc/verify_otp_state.dart';
import 'package:injectable/injectable.dart';

import '../../repository/firebase_repository.dart';

@injectable
class VeriFyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final FirebaseRepository firebaseRepository;
  VeriFyOtpBloc(FirebaseRepository repository)
      : firebaseRepository = repository,
        super(InitState()) {
    on<GetOtp>((event, emit) {
      _onSendOtp(event, emit);
    });

    on<VerifyOtp>(
      (event, emit) {
        _onVerifyOtp(event, emit);
      },
    );

    on<AuthVerificationCompleteEvent>(
      (event, emit) {
        _loginWithCredential(event, emit);
      },
    );

    on<OtpSent>(
      (event, emit) {
        emit(PhoneAuthCodeSentSuccess(event.verificationId));
      },
    );

    on<AuthErrorEvent>(
      (event, emit) {
        emit(Error(event.error));
      },
    );
  }

  getOtp(String mobile) {
    add(GetOtp(mobile));
  }

  verifyOtp(String otp,String verificationId) {
    add(VerifyOtp(otp, verificationId));
  }
  
  FutureOr<void> _onSendOtp(GetOtp event, Emitter<VerifyOtpState> emit) async {
    emit(Loading());
    try {
      await firebaseRepository.verifyPhone(
        phoneNumber: event.mobile,
        verificationCompleted: (PhoneAuthCredential credential) async {
          add(AuthVerificationCompleteEvent(credential));
        },
        codeSent: (String verificationId, int? resendToken) {
          add(OtpSent(verificationId, resendToken));
        },
        verificationFailed: (FirebaseAuthException e) {
          add(AuthErrorEvent(e.code));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  FutureOr<void> _onVerifyOtp(
      VerifyOtp event, Emitter<VerifyOtpState> emit) async {
    try {
      emit(InitState());
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpCode,
      );
      add(AuthVerificationCompleteEvent(credential));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  FutureOr<void> _loginWithCredential(
      AuthVerificationCompleteEvent event, Emitter<VerifyOtpState> emit) async {
    try {
      await firebaseRepository
          .verifyAndLogin(
              event.credential.verificationId!, event.credential.smsCode!)
          .then((user) {
        if (user.user != null) {
          emit(PhoneAuthVerified());
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(Error(e.code));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
