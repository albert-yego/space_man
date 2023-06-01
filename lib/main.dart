import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:spece_man/constants/widgettree.dart';
import 'package:spece_man/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:io';
import 'dart:ui';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spaceman',
      debugShowCheckedModeBanner: false,
      home: widgettree(),
    );
  }
}
