import 'package:flutter/material.dart';
import 'package:newsapp/styles/custom_theme.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    this.press,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: appBarColor,
        ),
        onPressed: widget.press,
        child: Row(
          children: [
            Container(
              width: 22,
              child: Icon(
                widget.icon,
                color: primaryColor,
              ),
            ),
            SizedBox(width: 20),
            Expanded(child: Text(widget.text)),
            Icon(
              Icons.arrow_forward_ios,
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
