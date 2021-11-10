import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/constants/padding_constant.dart';
import 'package:newsapp/service/news.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';

class AddNewPhoto extends StatefulWidget {
  final String title;

  AddNewPhoto({Key? key, required this.title}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  _AddNewPhotoState createState() => _AddNewPhotoState();
}

class _AddNewPhotoState extends State<AddNewPhoto> {
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  late File addFile;
  String uid = auth.currentUser!.uid.toString();
  String displayName = auth.currentUser!.displayName.toString();
  String? downloadUrl;
  addOnCamera() async {
    var uploadFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      addFile = File(uploadFile!.path);
    });
    Reference referencePath = FirebaseStorage.instance
        .ref()
        .child('newphotos')
        .child(displayName)
        .child(widget.title)
        .child('newPhoto.png');
    UploadTask addTask = referencePath.putFile(addFile);
    String url = await (await addTask).ref.getDownloadURL();
    setState(() {
      downloadUrl = url;
    });
  }

  getData() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var newsRef = _firestore
        .collection('News')
        .doc(displayName)
        .collection('items')
        .doc();
    var response = await newsRef.get();
    var map = response.data();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            widget.title,
            style: TextStyle(color: blackColor),
          ),
          backgroundColor: primaryColor,
        ),
        child: Padding(
          padding: PaddingConstants.instance.paddingLeftRightNormal,
          child: Container(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Form(
                    child: TextButton(
                      child: Text('Add Photo'),
                      onPressed: () {
                        addOnCamera();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
