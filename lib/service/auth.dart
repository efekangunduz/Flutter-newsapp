import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

uploadPhoto() async {
  // only add default photo from assets
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  File defaultPhoto = await getImageFileFromAssets('profilePhoto.png');
  FirebaseAuth auth = FirebaseAuth.instance;
  Reference referencePath = FirebaseStorage.instance
      .ref()
      .child('profilephotos')
      .child(auth.currentUser!.uid)
      .child('profilPhoto.png');
  UploadTask addTask = referencePath.putFile(defaultPhoto);
  String url = await (await addTask).ref.getDownloadURL();
}

signup(String email, String password, String username) async {
  try {
    await Firebase.initializeApp();
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? updateUser = FirebaseAuth.instance.currentUser;
    updateUser!.updateDisplayName(username);
    userSetup(username);
    uploadPhoto();
    print('///////// Success Register ////////////');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

signin(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    print('///////// Success Login ////////////');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

signout() async {
  await FirebaseAuth.instance.signOut();
  print('///// Success Logout //////.');
}

Future<void> userSetup(displayName) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  String uid = auth.currentUser!.uid.toString();
  bool editor = false;
  String name = '';
  String surname = '';
  String phone = '';
  DocumentReference documentReferencer = users.doc(displayName);

  Map<String, dynamic> data = <String, dynamic>{
    'displayName': displayName,
    'uid': uid,
    'editor': editor,
    'name': name,
    'surname': surname,
    'phone': phone,
  };

  await documentReferencer
      .set(data)
      .whenComplete(() => print("Users item added to the database"))
      .catchError((e) => print(e));
}
