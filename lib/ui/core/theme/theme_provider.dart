import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/utils/utils.dart';

class BaseThemeProvider extends ChangeNotifier {
  late ThemeMode themeMode;

  BaseThemeProvider({required bool isDarkMode}) {
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void setThemeMode(bool isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    await Cache.saveData('isDarkMode', isOn);
    notifyListeners();
  }
}
