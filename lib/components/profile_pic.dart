import 'package:flutter/material.dart';
import 'package:newsapp/service/auth.dart';
import 'package:newsapp/styles/custom_theme.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getPhotoUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            child: ClipOval(
              child: downloadUrl == null
                  ? Image.asset('assets/profilePhoto.png')
                  : Image.network(
                      downloadUrl!,
                      fit: BoxFit.fill,
                      width: 150,
                      height: 150,
                    ),
            ),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.black),
                  ),
                  primary: appBarColor,
                  backgroundColor: appBarColor,
                ),
                onPressed: () {
                  addOnCamera();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                },
                child: Icon(
                  Icons.camera,
                  color: primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
