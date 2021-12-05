import 'package:flutter/material.dart';
import 'package:newsapp/components/newDialogWidget.dart';
import 'package:newsapp/service/news.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/add_new_photo.dart';

class AddNewForm extends StatefulWidget {
  _AddNewFormState createState() => _AddNewFormState();
}

class _AddNewFormState extends State<AddNewForm> {
  String newTitle = '';
  String details = '';
  String description = '';
  String source = '';
  String _boxTitle = 'Hata !';
  String _errorMessage = 'Hatali Giris';
  String _buttonMessage = 'Ok';
  String publishedAt = DateTime.now().toString();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                key: ValueKey('newTitle'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.title,
                    color: Color(0xffDCA11E),
                  ),
                  labelText: 'New Title',
                ),
                validator: (value) {
                  if (value.toString().length < 6) {
                    return 'New title is too short';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    newTitle = value!;
                  });
                },
              ),
              TextFormField(
                key: ValueKey('description'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.description,
                    color: Color(0xffDCA11E),
                  ),
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value.toString().length < 6) {
                    return 'Description is too short';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    description = value!;
                  });
                },
              ),
              TextFormField(
                key: ValueKey('source'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.source,
                    color: Color(0xffDCA11E),
                  ),
                  labelText: 'Source',
                ),
                validator: (value) {
                  if (value.toString().length < 6) {
                    return 'Source is too short';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    source = value!;
                  });
                },
              ),
              TextFormField(
                key: ValueKey('details'),
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 8,
                maxLength: 1000,
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child:
                          Icon(Icons.comment, size: 40.0, color: primaryColor),
                    ),
                    hintText: "Details",
                    hintStyle: TextStyle(color: blackColor),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: blackColor)),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blackColor,
                  fontSize: 25.0,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty value";
                  }
                },
                onSaved: (value) {
                  setState(() {
                    details = value!;
                  });
                },
              ),
              TextButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    addNew(
                        description: description,
                        details: details,
                        newTitle: newTitle,
                        publishedAt: publishedAt,
                        source: source);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AddNewPhoto(title: newTitle)));
                  } else {
                    showMyDialog(
                        context, _boxTitle, _errorMessage, _buttonMessage);
                  }
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: primaryColor),
                child: Container(
                  width: screenSize.width * 0.3,
                  alignment: Alignment.center,
                  child: Text(
                    'Add New',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
