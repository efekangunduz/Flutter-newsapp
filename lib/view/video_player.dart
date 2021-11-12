import 'package:flutter/material.dart';
import 'package:newsapp/styles/custom_theme.dart';
import 'package:newsapp/view/base_view.dart';
import 'package:newsapp/view/video_items.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final String title;
  final String video;
  VideoApp({Key? key, required this.title, required this.video})
      : super(key: key);

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  @override
  Widget build(BuildContext context) {
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
          widget.title,
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: primaryColor,
      ),
      child: VideoItems(
        videoPlayerController: VideoPlayerController.network(
          widget.video,
        ),
        autoplay: false,
        looping: true,
      ),
    );
  }
}
