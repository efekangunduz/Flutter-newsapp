import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constants/padding_constant.dart';
import 'package:newsapp/routes/routes.dart';
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
  File? addImageFile;
  File? addVideoFile;

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
                            addImageOnCamera(addImageFile, widget.title);
                          },
                          icon: Icon(Icons.camera),
                        ),
                        IconButton(
                          onPressed: () {
                            addVideoOnCamera(addVideoFile, widget.title);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (Route<dynamic> route) => false);
                          },
                          icon: Icon(Icons.video_camera_front),
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
