import 'package:flutter/material.dart';
import 'package:newsapp/components/form/register_form.dart';
import 'package:newsapp/constants/padding_constant.dart';
import 'package:newsapp/styles/custom_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: PaddingConstants.instance.paddingLeftRightNormal,
          child: Container(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Container(
                        height: screenSize.height * 0.3,
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/BreakingNews.png"),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.1,
                      ),
                      Container(
                        height: screenSize.height * 0.6,
                        child: RegisterForm(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
