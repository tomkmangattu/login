import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/constants.dart';
import 'package:login/cubit/mobileauth_cubit.dart';
import 'package:login/screens/home%20page.dart';
import 'package:login/screens/otp%20page.dart';
import 'package:login/screens/user%20details.dart';
import 'package:login/screens/welcome%20page.dart';

class PhoneAuthScreen extends StatelessWidget {
  final String phoneNo;
  const PhoneAuthScreen({required this.phoneNo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MobileauthCubit>(
      create: (context) => MobileauthCubit(phoneNo: phoneNo),
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.blue,
          body: SafeArea(
            child: BlocConsumer<MobileauthCubit, MobileauthState>(
              listener: (context, state) {
                if (state is MobileauthError) {
                  _proceed(false, context);
                } else if (state is MobileauthSucess) {
                  _proceed(true, context);
                }
              },
              builder: (context, state) {
                if (state is MobileauthSucess) {
                  return _sucess();
                } else if (state is MobileauthOtpSend) {
                  return Center(child: OtpWidget());
                } else if (state is MobileauthError) {
                  return _error(state);
                }
                return _loading();
              },
            ),
          ),
        );
      }),
    );
  }

  void _proceed(final bool sucess, BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    if (sucess) {
      Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.id));
      Navigator.popAndPushNamed(context, UserDetails.id);
    } else {
      Navigator.pop(context);
    }
  }

  Center _error(MobileauthError state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error,
            color: Colors.white,
            size: 150,
          ),
          Text(state.error, style: h1Style),
        ],
      ),
    );
  }

  Center _loading() {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

  Center _sucess() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle_rounded,
          size: 150,
          color: Colors.white,
        ),
        Text(
          'Login Sucess',
          style: h1Style,
        )
      ],
    ));
  }
}
