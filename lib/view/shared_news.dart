import 'package:flutter/material.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';
import 'package:newsapp/view/shared_news_content.dart';

class SharedNews extends StatefulWidget {
  const SharedNews({Key? key}) : super(key: key);

  @override
  _SharedNewsState createState() => _SharedNewsState();
}

class _SharedNewsState extends State<SharedNews> {
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
          "Shared News",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: primaryColor,
      ),
      child: UserInformation(),
    );
  }
}
