import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/ui/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier {
  int _countNumber = 0;
  bool _isDarkMode = false;

  int get countNumber => _countNumber;

  void increment() {
    _countNumber++;
    notifyListeners();
  }

  void decrement() {
    _countNumber--;
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;

  void changeTheme(BuildContext context) {
    notifyListeners();
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    _isDarkMode = isDarkMode;
    Provider.of<ThemeProvider>(context, listen: false)
        .setThemeMode(!isDarkMode);
    // ThemeProvider().setThemeMode(_isDarkMode);
  }
}
