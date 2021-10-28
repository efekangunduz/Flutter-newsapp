import 'package:flutter/material.dart';
import 'package:newsapp/components/profile_pic.dart';
import 'package:newsapp/components/profile_menu.dart';
import 'package:newsapp/service/auth.dart';
import 'package:newsapp/styles/custom_theme.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
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
            "Profile",
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
                press: () => {},
              ),
              ProfileMenu(
                text: "Comments",
                icon: Icons.comment,
                press: () {},
              ),
              ProfileMenu(
                text: "Settings",
                icon: Icons.settings,
                press: () {},
              ),
              ProfileMenu(
                text: "Shared News",
                icon: Icons.article,
                press: () {},
              ),
              ProfileMenu(
                text: "Log Out",
                icon: Icons.logout,
                press: () {
                  signout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
