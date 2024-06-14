
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:personal_nursing/features/auth/presentation/login_screen.dart';
import 'package:personal_nursing/features/splash/presentation/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  runApp(const PersonalNurse());
}

class PersonalNurse extends StatelessWidget {
  const PersonalNurse({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),

    );
  }
}
