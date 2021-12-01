import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constants/border_constant.dart';

class Comments extends StatefulWidget {
  Comments({Key? key, required this.newTitle}) : super(key: key);

  final String newTitle;
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  late final Stream<QuerySnapshot> _comments = FirebaseFirestore.instance
      .collection('News')
      .doc(widget.newTitle)
      .collection('Comments')
      .orderBy('publishedAt', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _comments,
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
                child: Card(
                  elevation: 2.0,
                  shape: BorderConstants.instance.radiusAllCircularLow,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        data['comment'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Palatino',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            data['displayName'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Palatino',
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            data['publishedAt'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
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
        });
  }
}
