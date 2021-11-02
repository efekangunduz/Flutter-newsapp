import 'package:flutter/material.dart';
import 'package:newsapp/components/form/account_form.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
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
          "My Account",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: primaryColor,
      ),
      child: SingleChildScrollView(
        child: AccountForm(),
      ),
    );
  }
}
