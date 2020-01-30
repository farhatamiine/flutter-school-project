import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;
  ThemeNotifier(this._themeData);
  getTheme() => _themeData;
  setTheme(ThemeData theme) async {
    _themeData = theme;
    notifyListeners();
  }
}
