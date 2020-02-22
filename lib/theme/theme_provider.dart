import 'package:flutter/cupertino.dart';

class ThemeProvider extends InheritedWidget {
  final AppThemeData themeData;

 ThemeProvider({
    Key key,
    Widget child,
  })  : themeData = AppThemeData(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  AppThemeData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeProvider>()?.themeData;
}

class AppThemeData extends Object {}
