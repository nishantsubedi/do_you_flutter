import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:iremember/services/firebase_storage_service.dart';
import 'package:iremember/services/firestore_service.dart';

class ArticleBloc extends Object {

  final FireStoreServiceBase _fireStoreService;
  final FirbaseStorageServiceBase _firbaseStorageService;

  ArticleBloc(this._fireStoreService, this._firbaseStorageService);


  ValueNotifier<File> _image = ValueNotifier(null);

  ValueNotifier<File> get image => _image;

  ValueNotifier<String> _title = ValueNotifier(null);

  ValueNotifier<String> get title => _title;

  ValueNotifier<String> _description = ValueNotifier(null);

  ValueNotifier<String> get description => _description;

  addImage(File img) => _image.value = img;
  

  addTitle(String title) => _title.value = title;

  addDescription(String description) => _description.value = description;

  Future<bool> submit() async {
    var url = await _firbaseStorageService.addArticleImage(_image.value);
    var resp = await _fireStoreService.addArticle(_title.value, _description.value, url);
    return resp != null;
  }

  Stream<QuerySnapshot> get articles =>
    _fireStoreService.getArticles();



}