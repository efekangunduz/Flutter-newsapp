import 'package:flutter/material.dart';
import 'package:newsapp/model/new.dart';
import 'package:newsapp/service/auth.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/news_detail.dart';
import 'package:newsapp/constants/padding_constant.dart';
import 'package:newsapp/constants/border_constant.dart';
import 'package:newsapp/view/profile.dart';
import 'package:newsapp/view/register.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: blackColor),
          ),
          backgroundColor: primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              icon: Icon(Icons.person, color: blackColor),
            ),
            IconButton(
              onPressed: () {
                signout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterPage(title: 'Register')),
                    (route) => false);
              },
              icon: Icon(
                Icons.logout,
                color: blackColor,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: News.samples.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NewsDetail(
                          news: News.samples[index],
                        );
                      },
                    ),
                  );
                },
                child: buildNewCard(News.samples[index]),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildNewCard(News news) {
    return Card(
      elevation: 2.0,
      shape: BorderConstants.instance.radiusAllCircularLow,
      child: Padding(
        padding: PaddingConstants.instance.paddingAllLow,
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage(news.imageUrl),
            ),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              news.newTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Palatino',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
