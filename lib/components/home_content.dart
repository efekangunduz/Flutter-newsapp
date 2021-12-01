import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constants/border_constant.dart';
import 'package:newsapp/view/new_details.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final Stream<QuerySnapshot> _new =
      FirebaseFirestore.instance.collection('News').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _new,
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
                      return NewDetails(
                        newTitle: data['newTitle'],
                        author: data['displayName'],
                        source: data['source'],
                        description: data['description'],
                        details: data['details'],
                        photoUrl: data['photoUrl'],
                        videoUrl: data['videoUrl'],
                        publishedAt: data['publishedAt'].toString(),
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
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.network(data['photoUrl']),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      data['newTitle'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Palatino',
                      ),
                    ),
                    Text(
                      data['description'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Palatino',
                      ),
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




// GestureDetector(
//                   child: Card(
//                 elevation: 2.0,
//                 shape: BorderConstants.instance.radiusAllCircularLow,
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       width: 250,
//                       height: 250,
//                       child: Image.network(data['photoUrl']),
//                     ),
//                     const SizedBox(
//                       height: 8.0,
//                     ),
//                     Text(
//                       data['newTitle'],
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: 'Palatino',
//                       ),
//                     ),
//                     Text(
//                       data['description'],
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: 'Palatino',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),