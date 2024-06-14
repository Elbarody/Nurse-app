import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_nursing/features/auth/presentation/login_screen.dart';
import 'package:personal_nursing/features/splash/presentation/widgets/Splash_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}


class _SplashViewState extends State<SplashView> {


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => LoginScreen()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff229643),
      body: Center(child: SplashViewBody()),
    );
  }
}
