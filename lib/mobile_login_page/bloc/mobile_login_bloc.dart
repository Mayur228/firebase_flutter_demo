
import 'package:bloc/bloc.dart';
import 'package:firebase_demo_flutter/mobile_login_page/bloc/bloc.dart';
import 'package:firebase_demo_flutter/repository/firebase_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class MobileLoginBloc extends Bloc<MobileLoginEvent, MobileLoginState> {
  final FirebaseRepository firebaseRepository;
  MobileLoginBloc(FirebaseRepository repository)
      : firebaseRepository = repository,
        super(InitState()) {
    on<GetOtpEvent>(
      (event, emit) {
        // _onSendOtp(event, emit);
        emit(RedirectToOtpPage(event.mobile));
      },
    );
  }

  getOtp(String mobile) {
    add(GetOtpEvent(mobile));
  }


}
