import 'package:firebase_demo_flutter/details_page/details_page.dart';
import 'package:firebase_demo_flutter/login_page/bloc/login_bloc.dart';
import 'package:firebase_demo_flutter/login_page/bloc/login_state.dart';
import 'package:firebase_demo_flutter/mobile_login_page/mobile_login_page.dart';
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
          return mainWidget(context);
        } else if (state is Success) {
          bloc.redirectToDetailsPage(state.userData);
          return Container();
        } else if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return mainWidget(context);
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
        else if(state is RedirectToMobileState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MobileLoginPage(),
            ),
          );
        }
      },
    );
  }

  mainWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              bloc.loginWithMobile();
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.white, fixedSize: const Size(240, 50)),
            label: const Text(
              'Phone',
              style: TextStyle(color: Colors.black),
            ),
            icon: const Icon(
              Icons.phone_android,
              color: Colors.black,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('OR'),
          ),
          ElevatedButton(
            onPressed: (() {
              bloc.loginWithGoogle();
            }),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              fixedSize: const Size(240, 50),
            ),
            child: const Text(
              'Google',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
