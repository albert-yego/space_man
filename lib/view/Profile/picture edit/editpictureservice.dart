import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';

final editpictureServiceProvider = Provider<EditPictureService>((ref) => EditPictureService(ref.read));

class EditPictureService{
  final Reader _read;
  EditPictureService(this._read);
  final auth = FirebaseAuth.instance;
  late DatabaseReference dbRef;
  final storageref = FirebaseStorage.instance.ref();
  Uint8List? image;

  Future<Uint8List?> getImage() async {
    try{
      Uint8List pickedFile = await pickImage(ImageSource.gallery);
      image = pickedFile;
      return image;
      }on TypeError catch (e){
        if(e.toString() == "type 'Null' is not a subtype of type 'Uint8list'"){
          _showErrorToast('no image was selected');
        }
      } catch (e){
        _showErrorToast('image error');
      }
      return image;
  }

  Future<bool> uploadImage(Uint8List? file, String userK) async {
    try{
      final path = 'files/$userK';
      Reference profileref = await storageref.child(path);
      UploadTask uploadTask = profileref.putData(file!);
      TaskSnapshot snapshot = await uploadTask;
      String urlDownload = await snapshot.ref.getDownloadURL();
      FirebaseAuth.instance.currentUser?.updatePhotoURL(urlDownload);
      FirebaseDatabase.instance.ref().child('Users/$userK').update({
        'photoURL': urlDownload
      });
      return true;
    }catch(e){
      print('No image Selected');
      _showErrorToast('No image selected');
    }
    return false;
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagepicker = ImagePicker();
    XFile? _file = await _imagepicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No image Selected');
      _showErrorToast('No image selected');
    }
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