import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/service/auth.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/home.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String email = '';
  String password = '';
  String username = '';
  bool isLogin = false;

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
              !isLogin
                  ? TextFormField(
                      key: ValueKey('username'),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Color(0xffDCA11E),
                        ),
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value.toString().length < 6) {
                          return 'Username is so small';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          username = value!;
                        });
                      },
                    )
                  : Container(),
              TextFormField(
                key: ValueKey('email'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xffDCA11E),
                  ),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (!(value.toString().contains('@'))) {
                    return 'Invalid Email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              TextFormField(
                key: ValueKey('password'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xffDCA11E),
                  ),
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value.toString().length < 6) {
                    return 'Password is so small';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              TextButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    isLogin
                        ? signin(email, password)
                        : signup(email, password, username);
                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user == null) {
                        print('User is currently signed out!');
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MyHomePage(title: 'Home')));
                      }
                    });
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
                  child: isLogin
                      ? Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      child: isLogin
                          ? Text(
                              "Don't have an account? Register",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          : Text(
                              "Already have an account? Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      })
                ],
              )
            ],
          )),
    );
  }
}
