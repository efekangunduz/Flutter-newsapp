import 'package:flutter/material.dart';
import 'package:newsapp/components/editor_only_content.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';
import 'package:newsapp/components/shared_news_content.dart';

class EditorOnly extends StatefulWidget {
  const EditorOnly({Key? key}) : super(key: key);

  @override
  _EditorOnlyState createState() => _EditorOnlyState();
}

class _EditorOnlyState extends State<EditorOnly> {
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
          "Editor Only",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: primaryColor,
      ),
      child: EditorOnlyContent(),
    );
  }
}
