import 'package:flutter/material.dart';
import 'package:spece_man/login/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreenHAnimated extends StatelessWidget {
  const SplashScreenHAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/json files/shopping.json"),
      splashIconSize: 450,
      backgroundColor: Colors.white,
      nextScreen: Login(),
      pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}
