import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireStoreServiceBase {
  Future<String> addArticle(
      String name, String description, String imageURL);

  Stream<QuerySnapshot> getArticles();
}

class FireStoreService implements FireStoreServiceBase {
  Future<String> addArticle(
      String name, String description, String imageURL) async {
    DocumentReference docRef =
        Firestore.instance.collection('articles').document();

    await docRef.setData({
      'name': name,
      'description': description,
      'imageURL': imageURL,
      'updatedAt': DateTime.now().millisecondsSinceEpoch
    });
    return docRef.documentID;
  }

  Stream<QuerySnapshot> getArticles() {
    return Firestore.instance.collection('articles').snapshots();
  }
}
