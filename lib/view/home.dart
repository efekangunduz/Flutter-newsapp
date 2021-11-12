import 'package:flutter/material.dart';
import 'package:newsapp/service/auth.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';
import 'package:newsapp/view/home_content.dart';
import 'package:newsapp/view/profile.dart';
import 'package:newsapp/view/register.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            icon: Icon(Icons.person, color: blackColor),
          ),
          IconButton(
            onPressed: () {
              signout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterPage(title: 'Register')),
                  (route) => false);
            },
            icon: Icon(
              Icons.logout,
              color: blackColor,
            ),
          ),
        ],
      ),
      child: HomeContent(),
    );
  }
}
