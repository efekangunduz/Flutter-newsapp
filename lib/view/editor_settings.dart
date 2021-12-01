import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/service/auth.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';
import 'package:newsapp/constants/padding_constant.dart';

class EditorSetting extends StatefulWidget {
  EditorSetting({
    Key? key,
    required this.displayName,
    required this.name,
    required this.surname,
    required this.phone,
    required this.editor,
  }) : super(key: key);
  final String displayName, name, surname, phone, editor;
  @override
  _EditorSettingState createState() => _EditorSettingState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _EditorSettingState extends State<EditorSetting> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BaseView(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Row(
            children: [
              Text(
                widget.name,
                style: TextStyle(color: blackColor),
              ),
              SizedBox(width: 8),
              Text(
                widget.surname,
                style: TextStyle(color: blackColor),
              )
            ],
          ),
          backgroundColor: primaryColor),
      child: ListView(
        children: [
          Padding(
            padding: PaddingConstants.instance.paddingLeftRightNormal,
            child: Row(
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Text(
                  widget.surname,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16),
                Text(
                  widget.phone,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Editor: ',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.editor,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.done),
                onPressed: () {
                  editUser(widget.displayName);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                },
              ),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  deleteUser(widget.displayName);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
