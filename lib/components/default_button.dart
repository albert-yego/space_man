import 'package:flutter/material.dart';
import 'package:spece_man/services/constants.dart';

class defaultButton extends StatelessWidget {

  const defaultButton({super.key, required this.text ,required this.onPress});

  final Function()? onPress;
  final String? text;

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth / 2.2,
      height: getHeight / 18,
      child: TextButton(
        onPressed: onPress,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
        ), 
        child: Text(
          text!,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}