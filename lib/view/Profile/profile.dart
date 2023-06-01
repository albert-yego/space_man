import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spece_man/view/Profile/Profile%20edit/profileeditservice.dart';
import 'package:spece_man/view/Profile/profile edit/profile_edit.dart';
import 'package:spece_man/view/Profile/profileservice.dart';

import '../../components/default_button.dart';
import '../../constants/constants.dart';


class Profile extends ConsumerWidget {

  Profile({Key? key}) : super(key: key);

  String? authcurrent = FirebaseAuth.instance.currentUser?.email;
  String photo1 = FirebaseAuth.instance.currentUser!.photoURL.toString();

  final profileServiceProvider =Provider<ProfileService>((ref) => ProfileService(ref.read));

  Widget build(BuildContext context, WidgetRef ref){
    final profileService = ref.read(profileServiceProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: profileService.customerAccountDetails(authcurrent!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return displayUserInformation(context, snapshot);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    Map signedInCustomer = snapshot.data as Map;

    return Padding(
      padding: EdgeInsets.all(getHeight / 40),
      child: Expanded(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        (photo1),
                        height: getHeight / 6,
                        width: getWidth / 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getHeight / 20),
            TextField(
              readOnly: true,
              enabled: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: getHeight / 100, left: getWidth / 100),
                  labelText: "Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "${signedInCustomer['name']}",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            SizedBox(height: getHeight / 40),
            TextField(
              readOnly: true,
              enabled: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: getHeight / 100, left: getWidth / 100),
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "${signedInCustomer['email']}",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            SizedBox(height: getHeight / 40),
            TextField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: getHeight / 100, left: getWidth / 100),
                  labelText: "Phone Number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "+90${signedInCustomer['phone_number']}",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            SizedBox(height: getHeight / 9),
            defaultButton(
              text: "Edit Profile",
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>EditProfile(userK: signedInCustomer['uid'])
                  )
                );
              }
            ),
          ],
        )),
      ),
    );
  }
}