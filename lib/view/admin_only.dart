import 'package:flutter/material.dart';
import 'package:newsapp/components/admin_only_content.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';

class AdminOnly extends StatefulWidget {
  const AdminOnly({Key? key}) : super(key: key);

  @override
  _AdminOnlyState createState() => _AdminOnlyState();
}

class _AdminOnlyState extends State<AdminOnly> {
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
          "Admin Only",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: primaryColor,
      ),
      child: AdminOnlyContent(),
    );
  }
}
