import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends InheritedWidget {
  final AppThemeData themeData;

 ThemeProvider({
    Key key,
    Widget child,
  })  : themeData = AppThemeData(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AppThemeData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeProvider>()?.themeData;
}

class AppThemeData extends Object {
  final primaryWhite = Colors.white;
  final primaryBlue = Colors.blue;
}
