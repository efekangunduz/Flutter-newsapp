import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final CollectionReference _mainCollection = _firestore.collection('News');
Future<void> addNew({
  required String newTitle,
  required String description,
  required DateTime publishedAt,
  required String source,
  required String details,
  bool published = false,
}) async {
  String uid = auth.currentUser!.uid.toString();
  String displayName = auth.currentUser!.displayName.toString();
  DocumentReference documentReferencer =
      _mainCollection.doc(displayName).collection('items').doc(newTitle);

  Map<String, dynamic> data = <String, dynamic>{
    "newTitle": newTitle,
    "displayName": displayName,
    "details": details,
    "description": description,
    "publishedAt": publishedAt,
    "source": source,
    "published": published,
  };

  await documentReferencer
      .set(data)
      .whenComplete(() => print("News item added to the database"))
      .catchError((e) => print(e));
}
