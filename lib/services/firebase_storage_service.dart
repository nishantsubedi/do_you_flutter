

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

abstract class FirbaseStorageServiceBase{
  Future<String> addArticleImage(File file); 
}

class FirebaseStorageService implements FirbaseStorageServiceBase {
    Future<String> addArticleImage(File file) async {
    var fileName = Uuid().v1().replaceAll('-', '');
    var storageRef = FirebaseStorage().ref()
        .child(fileName);
    var uploadTask = storageRef
        .putFile(file);
    await uploadTask.onComplete;
    var url = await storageRef.getDownloadURL();
    return url;
  }
}