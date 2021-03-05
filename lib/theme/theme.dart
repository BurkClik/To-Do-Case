import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    appBarTheme: appBarTheme(),
    primaryColor: Color(0xFFFF9D73),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    elevation: 0,
    color: Colors.transparent,
  );
}
