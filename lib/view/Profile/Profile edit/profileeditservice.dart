import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:spece_man/view/Profile/profileservice.dart';
import '../profile_model.dart';

final profileeditServiceProvider = Provider<ProfileEditService>((ref) => ProfileEditService(ref.read));

class ProfileEditService{

  final getWidth = Get.width;
  final getHeight = Get.height;
  final Reader _read;
  ProfileEditService(this._read);
  final auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.ref().child('Users');

  Future<bool> change(String name, String email, String phoneN, String userK) async {

    try{
        Map<String, String> users = {
          'name': name,
          'phone_number': phoneN,
          'email': email,
        };

        dbRef
          .child(userK)
          .update(users)
          .then((value) => {});
          FirebaseAuth.instance.currentUser!.updateDisplayName(name);
          FirebaseAuth.instance.currentUser!.updateEmail(email);
        return true;
      // }
      }catch(e){
        print('Login error: $e');
        _showErrorToast('An error occurred during editing');
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