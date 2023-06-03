import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spece_man/model/Customer_model.dart';

import '../../services/firebaseauth.dart';

final profileServiceProvider = Provider<ProfileService>((ref) => ProfileService(ref.read));

class ProfileService {

  final Reader _read;
  ProfileService(this._read);
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  Future<List<Customer>> customerListMaker() async {
    List<Customer> customerList = [];
    final snapshot = await dbRef.child('Users').get();

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

  
  void updateCurrentUser() async {
    try {
      Map CurrUser = await customerAccountDetails(FireAuth().currentUser!.email);
      String curname = CurrUser['name'];
      String curphoto = CurrUser['photoURL'];
      FireAuth().currentUser?.updateDisplayName(curname);
      FireAuth().currentUser?.updatePhotoURL(curphoto);
      final ref = dbRef.child('Users').child('${CurrUser['uid']}');
      ref.update({'auth_uid': FireAuth().currentUser!.uid});
    } on TypeError catch (e) {
      print('updater: ${e.toString()}');
    } catch (e) {
      print('updater: ${e.toString()}');
    }
  }
}