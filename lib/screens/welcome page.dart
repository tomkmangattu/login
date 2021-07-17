import 'package:flutter/material.dart';
import 'package:login/screens/phoneno%20page.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = 'welcomePage';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _loginButton(
            'User SignUp',
            () => _signUp(true, context),
          ),
          _loginButton(
            'Provider SignUp',
            () => _signUp(false, context),
          ),
        ],
      ),
    );
  }

  void _signUp(bool user, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PhoneNoScreen(
          user: user,
        ),
      ),
    );
  }

  Widget _loginButton(final String text, final void Function() onpress) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: onpress,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 4,
              )
            ],
            color: Colors.blue,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
