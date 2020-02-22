import 'package:flutter/cupertino.dart';

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

class AppState extends Object {}
