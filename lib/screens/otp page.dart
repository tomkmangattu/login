import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/cubit/mobileauth_cubit.dart';

OutlineInputBorder _border = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.white),
);

class OtpWidget extends StatelessWidget {
  const OtpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter Otp',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            maxLength: 6,
            autofocus: true,
            keyboardType: TextInputType.number,
            cursorColor: Colors.white,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 9,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              counterStyle: TextStyle(color: Colors.white),
              focusedBorder: _border,
              border: _border,
              enabledBorder: _border,
            ),
            onChanged: (String value) {
              if (value.length == 6) {
                BlocProvider.of<MobileauthCubit>(context)
                    .signInWithPhoneNo(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
