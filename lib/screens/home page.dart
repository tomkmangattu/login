import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/welcome%20page.dart';

class HomePage extends StatelessWidget {
  static String id = 'home page';
  HomePage({Key? key}) : super(key: key);

  final String? _phoneNo = FirebaseAuth.instance.currentUser!.phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () => _logOut(context),
            child: Row(
              children: [
                Text('Log Out'),
                const SizedBox(width: 5),
                Icon(Icons.logout),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome  ' + _phoneNo!,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _logOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, WelcomeScreen.id);
  }
}
