import 'package:firebase_demo_flutter/details_page/details_page.dart';
import 'package:firebase_demo_flutter/login_page/bloc/login_bloc.dart';
import 'package:firebase_demo_flutter/login_page/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/injectable.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final bloc = getIt<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: provider(context));
  }

  BlocProvider<LoginBloc> provider(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: blocConsumer(bloc),
    );
  }

  BlocConsumer<LoginBloc, LoginState> blocConsumer(LoginBloc bloc) {
    return BlocConsumer(
      builder: (context, state) {
        if (state is NoDataSet) {
          return mainWidget();
        } else if (state is Success) {
          bloc.redirectToDetailsPage(state.userData);
          return Container();
        }else if(state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return mainWidget();
        }
      },
      listener: (context, state) {
        if (state is RedirectionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                userData: state.userData,
              ),
            ),
          );
        }
      },
    );
  }

  mainWidget() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          bloc.loginWithGoogle();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        ),
        child: const Text(
          'Google',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
