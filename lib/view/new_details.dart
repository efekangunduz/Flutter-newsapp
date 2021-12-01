import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/components/comments.dart';
import 'package:newsapp/service/news.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';
import 'package:newsapp/view/video_player.dart';
import 'package:newsapp/constants/padding_constant.dart';

class NewDetails extends StatefulWidget {
  NewDetails(
      {Key? key,
      required this.newTitle,
      required this.author,
      required this.source,
      required this.details,
      required this.description,
      required this.photoUrl,
      required this.videoUrl,
      required this.publishedAt})
      : super(key: key);
  final String newTitle,
      author,
      description,
      details,
      photoUrl,
      publishedAt,
      source,
      videoUrl;
  @override
  _NewDetailsState createState() => _NewDetailsState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _NewDetailsState extends State<NewDetails> {
  String comment = '';
  String publishedAt = DateTime.now().toString();
  final _formkey = GlobalKey<FormState>();
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
                  widget.author,
                  textAlign: TextAlign.end,
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
            height: 1,
          ),
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            widget.details,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                    key: ValueKey('comment'),
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
                    onSaved: (value) {
                      setState(() {
                        comment = value!;
                      });
                    }),
                TextButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                    }
                    addComment(
                      comment: comment,
                      newTitle: widget.newTitle,
                      publishedAt: publishedAt,
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
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
                      'Add Comment',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: screenSize.height * 0.4,
            height: screenSize.width * 0.8,
            child: Comments(
              newTitle: widget.newTitle,
            ),
          )
        ],
      ),
    );
  }
}
