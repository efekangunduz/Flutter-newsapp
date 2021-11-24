import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';
import 'package:newsapp/view/editor_only.dart';
import 'package:newsapp/view/profile.dart';
import 'package:newsapp/view/video_player.dart';
import 'package:newsapp/constants/padding_constant.dart';

class NewDetailsSetting extends StatefulWidget {
  NewDetailsSetting(
      {Key? key,
      required this.newTitle,
      required this.author,
      required this.source,
      required this.details,
      required this.description,
      required this.photoUrl,
      required this.videoUrl,
      required this.published,
      required this.publishedAt})
      : super(key: key);
  final String newTitle,
      author,
      description,
      details,
      photoUrl,
      publishedAt,
      source,
      published,
      videoUrl;
  @override
  _NewDetailsSettingState createState() => _NewDetailsSettingState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _NewDetailsSettingState extends State<NewDetailsSetting> {
  shareNew() async {
    CollectionReference news = FirebaseFirestore.instance.collection('News');
    await news.doc(widget.newTitle).update({'published': true});
  }

  deleteNew() async {
    CollectionReference news = FirebaseFirestore.instance.collection('News');
    await news.doc(widget.newTitle).delete();
  }

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
          title: Text(
            widget.newTitle,
            style: TextStyle(color: blackColor),
          ),
          backgroundColor: primaryColor),
      child: ListView(
        children: [
          SizedBox(
            height: screenSize.height * 0.4,
            width: double.infinity,
            child: Image.network(widget.photoUrl),
          ),
          Padding(
            padding: PaddingConstants.instance.paddingLeftRightNormal,
            child: Column(
              children: [
                Text(
                  widget.description,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.author),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: screenSize.width * 0.55,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => VideoApp(
                          video: widget.videoUrl, title: widget.newTitle)));
                },
                icon: Icon(
                  Icons.play_arrow,
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
            height: 32,
          ),
          Text(
            widget.details,
            style: const TextStyle(fontSize: 14),
          ),
          Padding(
            padding: PaddingConstants.instance.paddingLeftRightNormal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Shared :'),
                Text(
                  widget.published,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    shareNew();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    deleteNew();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
