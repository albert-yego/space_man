import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spece_man/components/default_button.dart';
import 'package:spece_man/view/Profile/profile.dart';
import 'package:spece_man/view/Profile/Profile edit/profileeditservice.dart';
import 'package:spece_man/view/Profile/splash/animated_splash_screen.dart';
import 'package:spece_man/view/base_scaffold/base_scaffold.dart';

import '../picture edit/edit_picture.dart';

final profileeditServiceProvider = Provider<ProfileEditService>((ref) => ProfileEditService(ref.read));

class EditProfile extends ConsumerWidget {

  EditProfile({Key? key, required this.userK}) : super(key: key);

  final String userK;

  final username = TextEditingController();
  final email = TextEditingController();
  final phoneN = TextEditingController();

  final _validationKey = GlobalKey<FormState>();
  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneNumberFocus = FocusNode();

  String photo1 = FirebaseAuth.instance.currentUser!.photoURL.toString();

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final profileeditService = ref.read(profileeditServiceProvider);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
         title: Text(
          'EDIT PROFILE',
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
            padding: EdgeInsets.symmetric(horizontal: profileeditService.getWidth / 25),
            child: Column(
              children: [
                SizedBox(
                  height: profileeditService.getHeight / 50,
                ),
                Container(
                child: Form(
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildProfilePicField(context,ref),
                          SizedBox(height: profileeditService.getHeight / 40),
                          buildNameFormField(),
                          SizedBox(height: profileeditService.getHeight / 20),
                          buildEmailFormField(),
                          SizedBox(height: profileeditService.getHeight / 20),
                          buildPhoneNumberFormField(),
                          SizedBox(height: profileeditService.getHeight / 20),
                          defaultButton(
                            onPress: () async {
                              _validationKey.currentState?.validate();
                              if (username.text.length == 0) {
                                nameFocus.requestFocus();
                              }else if (email.text.length==0) {
                                emailFocus.requestFocus();
                              }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email.text)) {
                                emailFocus.requestFocus();
                              } else if (phoneN.text.length == 0) {
                                phoneNumberFocus.requestFocus();
                              } else if (phoneN.text.length < 10 &&
                                  phoneN.text.length > 0) {
                                phoneNumberFocus.requestFocus();
                              }  else {
                                final name = username.text;
                                final Phone = phoneN.text;
                                final Email = email.text;
                                final success = await profileeditService.change(name,Email,Phone,userK); 
                                if(success){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SplashScreenPAnimated(),
                                    ),
                                  );
                                  Fluttertoast.showToast(
                                    msg: "Your profile has been edited successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.yellow,
                                    textColor: Colors.white,
                                    fontSize: 16,
                                  );
                                }
                              }
                            },
                            text: 'Save Changes',
                          ),
                          SizedBox(height: profileeditService.getHeight / 50),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    ),
  );
  }

  Center buildProfilePicField(BuildContext context, WidgetRef ref) {
    final profileeditService = ref.read(profileeditServiceProvider);
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                (photo1),
                height: profileeditService.getHeight / 6,
                width: profileeditService.getWidth / 3,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
                color: Colors.black,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPicture(userKey: userK),
                    ),
                  );
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: username,
      showCursor: true,
      cursorColor: Colors.black,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter username';
        } else {
          return null;
        }
      },
      focusNode: nameFocus,
      autofocus: false,
      decoration: InputDecoration(
        prefix: Padding(
          padding: EdgeInsets.all(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        hintText: "Username",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
      ),
    );
  }

  TextFormField buildEmailFormField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: email,
      showCursor: true,
      cursorColor: Colors.black,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter email';
        } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
            return 'incorrect email';
        } else {
          return null;
        }
      },
      focusNode: emailFocus,
      autofocus: false,
      decoration: InputDecoration(
        prefix: Padding(
          padding: EdgeInsets.all(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          Icons.email,
          color: Colors.black,
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: phoneN,
      maxLength: 10,
      showCursor: true,
      cursorColor: Colors.black,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter phone number';
        } else if (phoneN.text.length < 10 && phoneN.text.length > 0) {
          return 'incomplete phone number';
        } else {
          return null;
        }
      },
      focusNode: phoneNumberFocus,
      autofocus: false,
      decoration: InputDecoration(
        prefix: Padding(
          padding: EdgeInsets.all(4),
          child: Text('+90'),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        hintText: "Phone Number",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          Icons.phone_android,
          color: Colors.black,
        ),
      ),
    );
  }
}
