
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_demo_flutter/mobile_login_page/bloc/bloc.dart';
import 'package:firebase_demo_flutter/verify_otp_page/verify_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/injectable.dart';

class MobileLoginPage extends StatelessWidget {
  MobileLoginPage({Key? key}) : super(key: key);
  final phoneController = TextEditingController();
  final bloc = getIt<MobileLoginBloc>();
  String _countryCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Login'),
        ),
        body: provider(context));
  }

  BlocProvider<MobileLoginBloc> provider(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: blocConsumer(bloc),
    );
  }

  BlocConsumer<MobileLoginBloc, MobileLoginState> blocConsumer(
      MobileLoginBloc bloc) {
    return BlocConsumer(
      builder: (context, state) {
        if (state is InitState) {
          return mainWidget();
        }else if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }else {
          return mainWidget();
        }
      },
      listener: (context, state) {
        if(state is RedirectToOtpPage) {
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyOtpPage(mobile: state.mobile)
            ),
          );
        }
      },
    );
  }

  mainWidget() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              prefixIcon: CountryCodePicker(
                initialSelection: 'IN',
                showFlag: true,
                onChanged: (CountryCode contrycode) {
                  _countryCode = contrycode.dialCode ?? '';
                },
                onInit: (code) {
                  _countryCode = code?.dialCode ?? '';
                },
              ),
            ),
            cursorColor: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (() {
                bloc.getOtp(_countryCode + phoneController.text);
              }),
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  fixedSize: const Size(125, 50)),
              child: const Text(
                'Get Otp',
                style: TextStyle(fontSize: 17),
              ),
            ),
          )
        ],
      ),
    );
  }
}
