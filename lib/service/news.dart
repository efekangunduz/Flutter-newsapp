import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final CollectionReference _mainCollection = _firestore.collection('News');

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
  String uid = auth.currentUser!.uid.toString();
  String displayName = auth.currentUser!.displayName.toString();
  DocumentReference documentReferencer = _mainCollection.doc(newTitle);

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
  CollectionReference news = FirebaseFirestore.instance.collection('News');
  await news.doc(widgetTitle).update({'photoUrl': url});
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
  CollectionReference news = FirebaseFirestore.instance.collection('News');
  await news.doc(widgetTitle).update({'videoUrl': url});
}
