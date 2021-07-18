import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/home%20page.dart';
import 'screens/user details.dart';
import 'package:login/screens/welcome%20page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? WelcomeScreen.id
          : HomePage.id,
      routes: {
        WelcomeScreen.id: (_) => WelcomeScreen(),
        HomePage.id: (_) => HomePage(),
        UserDetails.id: (_) => UserDetails(),
      },
    );
  }
}
