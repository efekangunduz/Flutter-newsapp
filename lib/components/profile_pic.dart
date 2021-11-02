import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/styles/custom_theme.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  late File addFile;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? downloadUrl;
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      takePhoto();
    });
  }

  takePhoto() async {
    String connect = await FirebaseStorage.instance
        .ref()
        .child('profilephotos')
        .child(auth.currentUser!.uid)
        .child('profilPhoto.png')
        .getDownloadURL();
    setState(() {
      downloadUrl = connect;
    });
  }

  addOnCamera() async {
    var uploadFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      addFile = File(uploadFile!.path);
    });

    Reference referencePath = FirebaseStorage.instance
        .ref()
        .child('profilephotos')
        .child(auth.currentUser!.uid)
        .child('profilPhoto.png');
    UploadTask addTask = referencePath.putFile(addFile);
    String url = await (await addTask).ref.getDownloadURL();
    setState(() {
      downloadUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            child: ClipOval(
              child: downloadUrl == null
                  ? Image.asset('assets/profilePhoto.png')
                  : Image.network(
                      downloadUrl!,
                      fit: BoxFit.fill,
                      width: 150,
                      height: 150,
                    ),
            ),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.black),
                  ),
                  primary: appBarColor,
                  backgroundColor: appBarColor,
                ),
                onPressed: () {
                  addOnCamera();
                },
                child: Icon(
                  Icons.camera,
                  color: primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
