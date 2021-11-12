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
  late File addImageFile;
  late File addVideoFile;
  String uid = auth.currentUser!.uid.toString();
  String displayName = auth.currentUser!.displayName.toString();
  String? downloadImageUrl;
  String? downloadVideoUrl;
  addImageOnCamera() async {
    var uploadFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      addImageFile = File(uploadFile!.path);
    });
    Reference referencePath = FirebaseStorage.instance
        .ref()
        .child('newphotos')
        .child(widget.title)
        .child('newPhoto.png');
    UploadTask addTask = referencePath.putFile(addImageFile);
    String url = await (await addTask).ref.getDownloadURL();

    setState(() {
      downloadImageUrl = url;
    });
  }

  addVideoOnCamera() async {
    var uploadFile = await ImagePicker().pickVideo(source: ImageSource.camera);
    setState(() {
      addVideoFile = File(uploadFile!.path);
    });
    Reference referencePath = FirebaseStorage.instance
        .ref()
        .child('newvideos')
        .child(widget.title)
        .child('newVideo.mp4');
    UploadTask addTask = referencePath.putFile(addVideoFile);
    String url = await (await addTask).ref.getDownloadURL();
    setState(() {
      downloadVideoUrl = url;
    });
  }

  addImageVideoUrlOnFirestore() async {
    CollectionReference news = FirebaseFirestore.instance.collection('News');
    await news
        .doc(widget.title)
        .update({'photoUrl': downloadImageUrl, 'videoUrl': downloadVideoUrl});
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
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            addImageOnCamera();
                          },
                          icon: Icon(Icons.camera),
                        ),
                        IconButton(
                          onPressed: () {
                            addVideoOnCamera();
                          },
                          icon: Icon(Icons.video_camera_front),
                        ),
                        IconButton(
                          onPressed: () {
                            addImageVideoUrlOnFirestore();
                          },
                          icon: Icon(Icons.save),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
