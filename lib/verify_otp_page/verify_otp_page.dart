import 'package:firebase_demo_flutter/verify_otp_page/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/injectable.dart';

class VerifyOtpPage extends StatelessWidget {
  final String mobile;
  VerifyOtpPage({Key? key, required this.mobile}) : super(key: key);
  final otpController1 = TextEditingController();
  final otpController2 = TextEditingController();
  final otpController3 = TextEditingController();
  final otpController4 = TextEditingController();
  final otpController5 = TextEditingController();
  final otpController6 = TextEditingController();

  final bloc = getIt<VeriFyOtpBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verify Otp'),
        ),
        body: provider(context));
  }

  BlocProvider<VeriFyOtpBloc> provider(BuildContext context) {
    bloc.getOtp(mobile);
    return BlocProvider(
      create: (_) => bloc,
      child: blocConsumer(bloc),
    );
  }

  BlocConsumer<VeriFyOtpBloc, VerifyOtpState> blocConsumer(VeriFyOtpBloc bloc) {
    return BlocConsumer(builder: ((context, state) {
      if (state is InitState) {
        return mainWidget(context, null);
      } else if (state is Loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is Error) {
        return mainWidget(context, state.error);
      } else if (state is PhoneAuthVerified) {
        return const Center(
          child: Text(
            'Login Successed',
            style: TextStyle(fontSize: 20),
          ),
        );
      } else {
        return mainWidget(context, null);
      }
    }), listener: (context, state) {
      if(state is PhoneAuthCodeSentSuccess) {
        final String otp = '$otpController1$otpController2$otpController3$otpController4$otpController5$otpController6';
        bloc.verifyOtp(otp, state.verificationId);
      }
    });
  }

  mainWidget(BuildContext context, String? error) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Otp Sent on $mobile',
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              otpWidget(context, otpController1, true),
              const SizedBox(width: 5),
              otpWidget(context, otpController2, false),
              const SizedBox(width: 5),
              otpWidget(context, otpController3, false),
              const SizedBox(width: 5),
              otpWidget(context, otpController4, false),
              const SizedBox(width: 5),
              otpWidget(context, otpController5, false),
              const SizedBox(width: 5),
              otpWidget(context, otpController6, false)
            ],
          ),
          const SizedBox(height: 15),
          Visibility(
            visible: error != null,
            child: Text(
              error ?? 'some error occur',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: (() {}),
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  fixedSize: const Size(125, 45)),
              child: const Text(
                'Verify Otp',
                style: TextStyle(fontSize: 17),
              ),
            ),
          )
        ],
      ),
    );
  }

  otpWidget(
    BuildContext context,
    TextEditingController controller,
    bool autoFocus,
  ) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
