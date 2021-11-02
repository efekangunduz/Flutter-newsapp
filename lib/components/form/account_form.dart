import 'package:flutter/material.dart';
import 'package:newsapp/styles/custom_theme.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({Key? key}) : super(key: key);

  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  String name = '';
  String surname = '';
  String phone = '';

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
                key: ValueKey('name'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.title,
                    color: Color(0xffDCA11E),
                  ),
                  labelText: 'Add Name',
                ),
                validator: (value) {
                  if (value.toString().length < 3) {
                    return 'Name is too short';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    name = value!;
                  });
                },
              ),
              TextFormField(
                key: ValueKey('surname'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.description,
                    color: Color(0xffDCA11E),
                  ),
                  labelText: 'Add Surname',
                ),
                validator: (value) {
                  if (value.toString().length < 3) {
                    return 'Surname is too short';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    surname = value!;
                  });
                },
              ),
              TextFormField(
                key: ValueKey('phone'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Color(0xffDCA11E),
                  ),
                  labelText: 'Add Phone',
                ),
                validator: (value) {
                  if (value.toString().length < 11) {
                    return 'Phone is too short';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    phone = value!;
                  });
                },
              ),
              TextButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                  }
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    primary: Colors.white,
                    backgroundColor: primaryColor),
                child: Container(
                  width: screenSize.width * 0.3,
                  alignment: Alignment.center,
                  child: Text(
                    'Add User Info',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
