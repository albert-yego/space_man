import 'package:flutter/material.dart';
import 'package:spece_man/login/login.dart';
import 'package:spece_man/constants/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:spece_man/view/base_scaffold/base_scaffold.dart';

class SplashScreenLAnimated extends StatelessWidget {
  const SplashScreenLAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/json files/shopping.json"),
      splashIconSize: 450,
      backgroundColor: Colors.white,
      nextScreen: BaseScaffold(),
      pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}
