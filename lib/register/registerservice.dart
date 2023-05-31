import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final registerServiceProvider = Provider<RegisterService>((ref) => RegisterService(ref.read));

class RegisterService {
  final Reader _read;
  final dbRef = FirebaseDatabase.instance.ref().child('Users');

  RegisterService(this._read);

  Future<bool> registerUser(String email, String password, String name, String phoneN) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Registration successful
      final user = userCredential.user;
      if (user != null) {
        Map userDetails = {
          'name': name,
          'photoURL':'https://firebasestorage.googleapis.com/v0/b/project2-832cc.appspot.com/o/files%2Ficon.jpg?alt=media&token=483ddeeb-1a08-415c-b896-00c787c14566&_gl=1*1vyjroz*_ga*MzQxNTI0ODE3LjE2ODUzOTM5MTE.*_ga_CW55HF8NVT*MTY4NTU2NTk5NS41LjEuMTY4NTU2NzQ3My4wLjAuMA..',
          'email': email,
          'auth_uid': '',
          'phone_number': phoneN,
          'password': password
        };
        dbRef.push().set(userDetails);

        return true;
      }
    }on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Register error: $e');
        _showErrorToast(e.code);
      }
      if (e.code == 'invalid-email') {
        print('Register error: $e');
        _showErrorToast(e.code);
      }
      if (e.code == 'weak-password') {
        print('Register error: $e');
        _showErrorToast(e.code);
    }
    } catch (e) {
      print('Register error: $e');
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

