import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class BaseView extends StatelessWidget {
  final AppBar? appBar;
  final Widget child;

  BaseView({required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: this.appBar != null ? this.appBar : null,
          body: Padding(
            padding: context.paddingLow,
            child: this.child,
          )),
    );
  }
}
