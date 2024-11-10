import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_management/themes/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  bool isDark = false;

  // set themeData(ThemeData themeData) {
  //   _themeData = themeData;
  //   notifyListeners();
  // }

  // void toggleTheme() {
  //   _themeData = _themeData == lightTheme ? darkTheme : lightTheme;
  //   notifyListeners();
  // }

  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() async {
    isDark = !isDark;
    _themeData = isDark ? darkTheme : lightTheme;
    saveTheme(isDark);
    notifyListeners();
  }

  void saveTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isDark')) {
      isDark = prefs.getBool('isDark')!;
      _themeData = isDark ? darkTheme : lightTheme;
      notifyListeners();
    }
  }
}
