import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/view/profile.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final CollectionReference mainCollection = firestore.collection('News');

Future<void> addNew({
  required String newTitle,
  required String description,
  required String publishedAt,
  required String source,
  required String details,
  String photoUrl = '',
  String videoUrl = '',
  bool published = false,
}) async {
  String displayName = auth.currentUser!.displayName.toString();
  DocumentReference documentReferencer = mainCollection.doc(newTitle);

  Map<String, dynamic> data = <String, dynamic>{
    "newTitle": newTitle,
    "displayName": displayName,
    "details": details,
    "description": description,
    "publishedAt": publishedAt,
    "source": source,
    "published": published,
    "photoUrl": photoUrl,
    "videoUrl": videoUrl,
  };

  await documentReferencer
      .set(data)
      .whenComplete(() => print("News item added to the database"))
      .catchError((e) => print(e));
}

Future<void> addComment({
  required String comment,
  required String newTitle,
  required String publishedAt,
}) async {
  String displayName = auth.currentUser!.displayName.toString();
  DocumentReference documentReferencer = mainCollection.doc(newTitle);
  CollectionReference commentCollection =
      documentReferencer.collection('Comments');

  Map<String, dynamic> data = <String, dynamic>{
    "displayName": displayName,
    "publishedAt": publishedAt,
    "comment": comment,
  };

  await commentCollection
      .doc()
      .set(data)
      .whenComplete(() => print("News item added to the database"))
      .catchError((e) => print(e));
}

String? downloadImageUrl;
String? downloadVideoUrl;
addImageOnCamera(addImageFile, widgetTitle) async {
  var uploadFile = await ImagePicker().pickImage(source: ImageSource.camera);
  addImageFile = File(uploadFile!.path);
  Reference referencePath = FirebaseStorage.instance
      .ref()
      .child('newphotos')
      .child(widgetTitle)
      .child('newPhoto.png');
  UploadTask addTask = referencePath.putFile(addImageFile);
  String url = await (await addTask).ref.getDownloadURL();
  downloadImageUrl = url;
  await mainCollection.doc(widgetTitle).update({'photoUrl': url});
}

addVideoOnCamera(addVideoFile, widgetTitle) async {
  var uploadFile = await ImagePicker().pickVideo(source: ImageSource.camera);
  addVideoFile = File(uploadFile!.path);
  Reference referencePath = FirebaseStorage.instance
      .ref()
      .child('newvideos')
      .child(widgetTitle)
      .child('newVideo.mp4');
  UploadTask addTask = referencePath.putFile(addVideoFile);
  String url = await (await addTask).ref.getDownloadURL();
  downloadVideoUrl = url;
  await mainCollection.doc(widgetTitle).update({'videoUrl': url});
}

shareNew(widgetTitle) async {
  await mainCollection.doc(widgetTitle).update({'published': true});
}

deleteNew(widgetTitle) async {
  await mainCollection.doc(widgetTitle).delete();
}
