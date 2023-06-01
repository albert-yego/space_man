import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:base_x/base_x.dart';
import 'package:spece_man/view/Profile/profile.dart';
import 'package:spece_man/view/Profile/splash/animated_splash_screen.dart';
import 'package:spece_man/view/base_scaffold/base_scaffold.dart';

import '../../../components/default_button.dart';
import '../../../constants/constants.dart';
import 'editpictureservice.dart';

final editpictureServiceProvider = Provider<EditPictureService>((ref) => EditPictureService(ref.read));

class EditPicture extends ConsumerWidget {
  EditPicture({Key? key, required this.userKey}) : super(key: key);

  final String userKey;

  String photo1 = FirebaseAuth.instance.currentUser!.photoURL.toString();
  bool newPhotoExists = false;
  bool oldPhotoExists = true;

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final editpictureService = ref.read(editpictureServiceProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'EDIT PROFILE PICTURE',
          style: GoogleFonts.bebasNeue(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth / 25),
            child: Column(
              children: [
                SizedBox(
                  height: getHeight / 50,
                ),
                Text(
                  'Choose Profile Picture',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: getHeight / 1500,
                ),
                Text(
                  "Choose from gallery",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getHeight / 10,
                ),
                Container(
                  color: Colors.grey[300],
                  child: Form(
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: getHeight / 40),
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
                            SizedBox(height: getHeight / 40),
                            defaultButton(
                              text: 'Upload',
                              onPress: () async {
                                Uint8List? s = await editpictureService.getImage();
                                final success = await editpictureService.uploadImage(s, userKey);
                                if(success){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SplashScreenPAnimated(),
                                    ),
                                  );
                                  Fluttertoast.showToast(
                                    msg: "Photo Uploaded",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.purple,
                                    textColor: Colors.white,
                                    fontSize: 16,
                                  );
                                }
                              }
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}
