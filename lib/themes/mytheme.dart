import 'package:flutter/material.dart';

final ThemeData myTheme = new ThemeData(
  brightness: Brightness.light,
  primaryColorBrightness: Brightness.light,
  primaryColor: Color(0xff140D34),
  accentColor: Color(0xff4AA6CD),
  accentColorBrightness: Brightness.light,
  textTheme: TextTheme(title: TextStyle( color: Colors.white ),
  ),
);

class CatColors{
  static final Color catBlue = new Color(0xff00FFFF);
  static final Color catGreen= new Color(0xff00FFB3);
  static final Color catViolet = new Color(0xff8F80F1);
  static final Color catPink = new Color(0xffD5ACF9);
}

class TaskColors{
  static final Color diasbled = Colors.grey;
  static final Color negativeBtn = new Color(0xffEF426A);
  static final Color positiveBtn = new Color(0xff4AA6CD);
}