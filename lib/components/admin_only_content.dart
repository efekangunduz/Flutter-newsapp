import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constants/border_constant.dart';
import 'package:newsapp/view/editor_settings.dart';

class AdminOnlyContent extends StatefulWidget {
  @override
  _AdminOnlyContentState createState() => _AdminOnlyContentState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _AdminOnlyContentState extends State<AdminOnlyContent> {
  final Query _new = FirebaseFirestore.instance
      .collection('Users')
      .where("editor", isEqualTo: false);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _new.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditorSetting(
                        displayName: data['displayName'],
                        name: data['name'],
                        surname: data['surname'],
                        phone: data['phone'],
                        editor: data['editor'].toString(),
                      );
                    },
                  ),
                );
              },
              child: Card(
                elevation: 2.0,
                shape: BorderConstants.instance.radiusAllCircularLow,
                child: Column(
                  children: <Widget>[
                    Text(
                      data['displayName'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Palatino',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Palatino',
                          ),
                        ),
                        Text(
                          data['surname'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Palatino',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
