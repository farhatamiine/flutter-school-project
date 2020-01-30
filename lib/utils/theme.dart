import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.indigo,
  appBarTheme: AppBarTheme(
    color: Color(0xff082361),
  ),
  primaryColor: Colors.indigo,
  scaffoldBackgroundColor: const Color(0xff013C93),
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF1a237e),
  bottomAppBarTheme:
      BottomAppBarTheme(color: Color(0xFF181241), elevation: 0.0),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Color(0xFF1a237e)),
  hintColor: Color(0xff013C93),
  dividerColor: Colors.black12,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    labelStyle: TextStyle(color: Color(0xff013C93), fontSize: 24.0),
  ),
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  primaryIconTheme: IconThemeData(
    color: Color(0xff082361),
  ),
  iconTheme: IconThemeData(
    color: Color(0xff082361),
  ),
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
