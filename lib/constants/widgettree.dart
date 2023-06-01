import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spece_man/login/login.dart';
import 'package:spece_man/view/base_scaffold/base_scaffold.dart';

class widgettree extends StatefulWidget {
  const widgettree({super.key});

  State<widgettree> createState() => _widgettreeState();
}

class _widgettreeState extends State<widgettree> {
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return BaseScaffold();
        }else{
          return Login();
        }
      },
    );
  }
}