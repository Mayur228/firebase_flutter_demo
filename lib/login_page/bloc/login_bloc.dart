import 'package:bloc/bloc.dart';
import 'package:firebase_demo_flutter/constant/constant.dart';
import 'package:firebase_demo_flutter/login_page/bloc/bloc.dart';
import 'package:firebase_demo_flutter/login_page/model/user_data.dart';
import 'package:firebase_demo_flutter/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

import '../../repository/firebase_repository.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseRepository firebaseRepository;
  final SharedPreferencesRepository sharedPreferencesRepository;

  LoginBloc(
      {required FirebaseRepository repository,
      required SharedPreferencesRepository preferencesRepository})
      : firebaseRepository = repository,
        sharedPreferencesRepository = preferencesRepository,
        super(NoDataSet()) {
    on<GoogleLoginEvent>(
      (event, emit) async {
        final data = await firebaseRepository.signInWithGoogle();

        sharedPreferencesRepository.saveUserData(Constant.USER_DATA, data);
        emit(Success(data!));
      },
    );

    on<RedirectToDetailsPage>(
      (event, emit) => emit(
        RedirectionState(event.userData),
      ),
    );

    on<CheckUserSingIn>(
      (event, emit) async {
        emit(Loading());

        final currentState = state;

        final isSingIn = await firebaseRepository.isSignIn();
        if (isSingIn) {
          final userData =
              await sharedPreferencesRepository.getUserData(Constant.USER_DATA);
          var check = UserData.fromJson(userData);
          emit(RedirectionState(check));
          emit(currentState);
        } else {
          emit(NoDataSet());
        }
      },
    );

    on<LoginWithMobile>(
      (event, emit) => emit(
        RedirectToMobileState(),
      ),
    );

    isUserSignIn();
  }

  loginWithGoogle() {
    add(GoogleLoginEvent());
  }

  redirectToDetailsPage(UserData userData) {
    add(RedirectToDetailsPage(userData));
  }

  isUserSignIn() {
    add(CheckUserSingIn());
  }

  loginWithMobile() {
    add(LoginWithMobile());
  }
}
