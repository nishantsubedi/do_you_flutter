import 'package:flutter/cupertino.dart';
import 'package:iremember/blocs/article_bloc.dart';
import 'package:iremember/services/firebase_storage_service.dart';
import 'package:iremember/services/firestore_service.dart';

class AppStateProvider extends InheritedWidget {
  final AppState state;

 AppStateProvider({
    Key key,
    Widget child,
  })  : state = AppState(),
        super(key: key, child: child);
        
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppStateProvider>()?.state;
}

class AppState extends Object {
  final ArticleBloc articleBloc;

  AppState() :
    articleBloc = ArticleBloc(FireStoreService(), FirebaseStorageService());
  
}
