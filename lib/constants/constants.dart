import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final getWidth = Get.width;
final getHeight = Get.height;

final DBref = FirebaseDatabase.instance.ref();

class Customer {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String photoURL;
  final String auth_uid;

  Customer(this.uid, this.name, this.phone, this.email,this.photoURL, this.auth_uid);
}
Future<List<Customer>> customerListMaker() async {
  List<Customer> customerList = [];
  final snapshot = await DBref.child('Users').get();

  try {
    if (snapshot.exists) {
      Map<dynamic, dynamic> data = snapshot.value as Map;
      data.forEach((key, value) {
        customerList.add(Customer(
            key,
            value['name'],
            value['phone_number'],
            value['email'],
            value['photoURL'],
            value['auth_uid']
            ),
        );
      });
      return customerList;
    } else {
      return [];
    }
  } on TypeError catch (e) {
    print('customerlist: ${e.toString()}');
    return [];
  } catch (e) {
    print('customerlist: ${e.toString()}');
    return [];
  }
}

Future<Map<dynamic, dynamic>> customerAccountDetails(String? email) async {
  List<Customer> customers = await customerListMaker();
  Map<dynamic, dynamic> signedCustomer = {};

  try {
    for (var element in customers) {
      if (element.email == email) {
        signedCustomer = {
          'name': element.name,
          'phone_number': element.phone,
          'email': element.email,
          'photoURL': element.photoURL,
          'uid': element.uid,
          'auth_uid': element.auth_uid,
        };
        break;
      } else {
        continue;
      }
    }
    return signedCustomer;
  } on TypeError catch (e) {
    print('customerlist: ${e.toString()}');
    return {};
  } catch (e) {
    print('customerlist: ${e.toString()}');
    return {};
  }
}
void updater() async {
  try {
    Map CurrUser = await customerAccountDetails(FirebaseAuth.instance.currentUser!.email);
    String curname = CurrUser['name'];
    String curphoto = CurrUser['photoURL'];
    FirebaseAuth.instance.currentUser?.updateDisplayName(curname);
    FirebaseAuth.instance.currentUser?.updatePhotoURL(curphoto);
    DatabaseReference AuthRef = FirebaseDatabase.instance
        .ref()
        .child('Users')
        .child('${CurrUser['uid']}');
    AuthRef.update({'auth_uid': FirebaseAuth.instance.currentUser!.uid});
  } on TypeError catch (e) {
    print('updater: ${e.toString()}');
  } catch (e) {
    print('updater: ${e.toString()}');
  }
}