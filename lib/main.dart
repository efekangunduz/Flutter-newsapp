import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/components/home_content.dart';
import 'package:newsapp/components/profile_content.dart';
import 'package:newsapp/routes/routes.dart';
import 'package:newsapp/view/home.dart';
import 'package:newsapp/view/register.dart';
import 'package:newsapp/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
        title: 'News',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.black,
            secondary: Colors.orange,
          ),
        ),
        //home: ProfileContent(),
        home: Splash(),
        routes: {
          Routes.splashRoute: (_) => Splash(),
          Routes.signInRoute: (_) => RegisterPage(title: 'Register'),
          Routes.homeRoute: (_) => MyHomePage(),
        });
  }
}
