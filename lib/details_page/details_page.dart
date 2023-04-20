import 'package:firebase_demo_flutter/details_page/bloc/bloc.dart';
import 'package:firebase_demo_flutter/login_page/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/injectable.dart';

class DetailsPage extends StatelessWidget {
  final UserData userData;

  DetailsPage({Key? key, required this.userData}) : super(key: key);
  final bloc = getIt<DetailsBloc>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          centerTitle: true,
          actions: [
            InkWell(
              child: const Icon(Icons.logout),
              onTap: () {
                bloc.singOut();
              },
            )
          ],
          leading: BackButton(
            onPressed: (() {
              SystemNavigator.pop();
            }),
          ),
        ),
        body: provider(context),
      ),
    );
  }

  BlocProvider<DetailsBloc> provider(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: blocConsumer(bloc),
    );
  }

  BlocConsumer<DetailsBloc, DetailsState> blocConsumer(DetailsBloc bloc) {
    return BlocConsumer(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userData.url),
                ),
                const SizedBox(height: 10),
                textWidget(userData.name),
                const SizedBox(height: 10),
                textWidget(userData.email),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is RedirectToLogin) {
          Navigator.pop(context);
        }
      },
    );
  }

  textWidget(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20),
    );
  }
}
