import 'package:flutter/material.dart';
import 'package:newsapp/constants/border_constant.dart';
import 'package:newsapp/constants/padding_constant.dart';
import 'package:newsapp/model/new.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';
import 'package:newsapp/view/news_detail.dart';

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
        backgroundColor: primaryColor,
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
      ),
      child: SafeArea(
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
