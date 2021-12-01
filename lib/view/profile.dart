import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/components/profile_pic.dart';
import 'package:newsapp/components/profile_menu.dart';
import 'package:newsapp/service/auth.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/add_new.dart';
import 'package:newsapp/view/admin_only.dart';
import 'package:newsapp/view/editor_only.dart';
import 'package:newsapp/view/my_account.dart';
import 'package:newsapp/view/shared_news.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

String displayName = auth.currentUser!.displayName.toString();

class _ProfileScreenState extends State<ProfileScreen> {
  bool data = false;
  bool data2 = false;
  var documentStream;
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getData();
      getData2();
    });
  }

  getData() async {
    documentStream = await FirebaseFirestore.instance
        .collection('Users')
        .doc(displayName)
        .get();
    setState(() {
      data = documentStream['editor'];
    });
  }

  getData2() async {
    documentStream = await FirebaseFirestore.instance
        .collection('Users')
        .doc(displayName)
        .get();
    setState(() {
      data2 = documentStream['admin'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: primaryColor,
          title: Text(
            'Profile',
            style: TextStyle(color: blackColor),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              ProfilePic(),
              SizedBox(height: 20),
              ProfileMenu(
                text: "My Account",
                icon: Icons.person,
                press: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyAccount(title: 'My Account'))),
                },
              ),
              ProfileMenu(
                text: "My Comments",
                icon: Icons.comment,
                press: () {},
              ),
              ProfileMenu(
                text: "Add New",
                icon: Icons.add_box,
                press: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddNew()));
                },
              ),
              ProfileMenu(
                text: 'Shared News',
                icon: Icons.article,
                press: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SharedNews()));
                },
              ),
              !data
                  ? Container()
                  : ProfileMenu(
                      text: 'Editor Only',
                      icon: Icons.article,
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditorOnly()));
                      },
                    ),
              !data2
                  ? Container()
                  : ProfileMenu(
                      text: 'Admin Only',
                      icon: Icons.article,
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AdminOnly()));
                      },
                    ),
              ProfileMenu(
                text: "Logout",
                icon: Icons.article,
                press: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
