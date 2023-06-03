import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spece_man/services/firebaseauth.dart';

final loginServiceProvider = Provider<LoginService>((ref) => LoginService(ref.read));

class LoginService{
  final Reader _read;
  LoginService(this._read);

  Future<bool> login(String email, String password) async {
    try{
      await FireAuth().signInWithEmailAndPassword(email: email,password: password);
      return true;
    }on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        print('Login error: $e');
        _showErrorToast(e.code);
      }
      if(e.code == "wrong-password"){
        print('Login error: $e');
        _showErrorToast(e.code);
      }
      if(e.code == "invalid-email"){
        print('Login error: $e');
        _showErrorToast(e.code);
      }
    }catch (e){
      print('Login error: $e');
      _showErrorToast('An error occurred during registration');
    }
    return false;
  }

  void _showErrorToast(String errorMessage) {
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}


