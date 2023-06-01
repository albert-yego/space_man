import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spece_man/constants/constants.dart';

final profileServiceProvider = Provider<ProfileService>((ref) => ProfileService(ref.read));

class ProfileService {

  final Reader _read;
  ProfileService(this._read);

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
}