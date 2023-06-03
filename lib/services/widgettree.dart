import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spece_man/login/login.dart';
import 'package:spece_man/view/base_scaffold/base_scaffold.dart';

class authStateCheckService extends StatefulWidget {
  const authStateCheckService({super.key});

  State<authStateCheckService> createState() => _authStateCheckServiceState();
}

class _authStateCheckServiceState extends State<authStateCheckService> {
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