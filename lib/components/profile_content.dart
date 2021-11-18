import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constants/border_constant.dart';
import 'package:newsapp/view/new_details.dart';
import 'package:newsapp/view/profile.dart';

class ProfileContent extends StatefulWidget {
  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  Stream documentStream =
      FirebaseFirestore.instance.collection('Users').doc('ABC123').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: documentStream,
        builder: (context, snapshot) => build(context),
        initialData: documentStream);
  }
}
