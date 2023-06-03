import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spece_man/register/registerservice.dart';
import 'package:spece_man/register/splash/animated_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final registerServiceProvider =Provider<RegisterService>((ref) => RegisterService(ref.read));

class Register extends ConsumerWidget {

  Register({Key? key}) : super(key: key);

  late TextEditingController _usernameController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  final _validationKey = GlobalKey<FormState>();
  final usernameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerService = ref.read(registerServiceProvider);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: _usernameController,
                            showCursor: true,
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter username';
                              } else {
                                return null;
                              }
                            },
                            focusNode: usernameFocus,
                            autofocus: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.white),
                              icon: Icon(
                                Icons.account_circle,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: _emailController,
                            showCursor: true,
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
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
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.white),
                              icon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: _passwordController,
                            showCursor: true,
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else {
                                return null;
                              }
                            },
                            focusNode: passwordFocus,
                            autofocus: false,
                            decoration: InputDecoration(
                              prefix: Padding(
                                padding: EdgeInsets.all(4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.white),
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: _phoneController,
                            maxLength: 10,
                            showCursor: true,
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter phone number';
                              } else if (_phoneController.text.length < 10 &&
                                  _phoneController.text.length > 0) {
                                return 'incomplete phone number';
                              } else {
                                return null;
                              }
                            },
                            focusNode: phoneFocus,
                            autofocus: false,
                            decoration: InputDecoration(
                              prefix: Padding(
                                padding: EdgeInsets.all(4),
                                child: Text('+90'),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              hintText: "Phone Number",
                              hintStyle: TextStyle(color: Colors.white),
                              icon: Icon(
                                Icons.phone_android,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async{
                                      _validationKey.currentState?.validate();
                                      if (_usernameController.text.length == 0) {
                                        usernameFocus.requestFocus();
                                      } else if (_emailController.text.length == 0) {
                                        emailFocus.requestFocus();
                                      } else if (!RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(_emailController.text)) {
                                        emailFocus.requestFocus();
                                      } else if (_phoneController.text.length == 0) {
                                        phoneFocus.requestFocus();
                                      } else if (_phoneController.text.length < 10 &&
                                          _phoneController.text.length > 0) {
                                        phoneFocus.requestFocus();
                                      } else if (_passwordController.text.length == 0) {
                                        passwordFocus.requestFocus();
                                      } else {
                                        final email = _emailController.text;
                                        final password = _passwordController.text;
                                        final name = _usernameController.text;
                                        final phoneN = _phoneController.text;
                                        final success = await registerService.registerUser(email, password, name, phoneN);  
                                        if (success) {
                                          Fluttertoast.showToast(
                                            msg: "You have registered successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.yellow,
                                            textColor: Colors.white,
                                            fontSize: 16,
                                          ).then((value) => {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => SplashScreenHAnimated(),
                                              ),
                                            )
                                          });
                                        }
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}