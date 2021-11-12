import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/view/base_view.dart';
import 'package:newsapp/view/home.dart';
import 'package:newsapp/view/register.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      if (FirebaseAuth.instance.currentUser == null) {
        // user not logged ==> Login Screen
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => RegisterPage(
                      title: 'Register',
                    )),
            (route) => false);
      } else {
        // user already logged in ==> Home Screen
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => MyHomePage()), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_image, _text],
      ),
    ));
  }

  Widget get _image => Image.asset('assets/BreakingNews.png');

  Widget get _text => TweenAnimationBuilder(
        duration: Duration(seconds: 1),
        tween: Tween<double>(begin: 20, end: 70),
        builder: (_, double value, __) {
          return Wrap(
            children: [
              Text('News-',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: value,
                      color: Theme.of(context).primaryColor)),
              Text('APP',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: value, color: Theme.of(context).primaryColor))
            ],
          );
        },
      );
}
