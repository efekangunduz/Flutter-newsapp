import 'package:flutter/material.dart';
import 'package:newsapp/styles/custom_theme.dart';
import '../model/new.dart';
import 'package:newsapp/constants/padding_constant.dart';

class NewsDetail extends StatefulWidget {
  final News news;

  const NewsDetail({Key? key, required this.news}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: blackColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              widget.news.title,
              style: TextStyle(color: blackColor),
            ),
            backgroundColor: primaryColor),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: PaddingConstants.instance.paddingAllLow,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(widget.news.authorImage),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.1,
                    ),
                    Text(widget.news.author),
                  ],
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.3,
                width: double.infinity,
                child: Image(
                  image: AssetImage(
                    widget.news.imageUrl,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenSize.width * 0.6,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.comment,
                      color: primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.thumb_up,
                      color: primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.thumb_down,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                widget.news.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                widget.news.details,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              Form(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 8,
                  maxLength: 1000,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(Icons.comment,
                            size: 40.0, color: primaryColor),
                      ),
                      hintText: "Comment",
                      hintStyle: TextStyle(color: blackColor),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(new Radius.circular(25.0))),
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
                ),
              ),
              Text(
                widget.news.comments,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
