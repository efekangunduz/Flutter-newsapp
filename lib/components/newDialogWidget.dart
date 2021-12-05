import 'package:flutter/material.dart';

Future<void> showMyDialog(
    context, boxTitle, errorMessage, buttonMessage) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(boxTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(errorMessage),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(buttonMessage),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      });
}
