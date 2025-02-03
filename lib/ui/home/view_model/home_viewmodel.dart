import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/ui/core/theme/app_theme.dart';
import 'package:my_flutter_mvvm_template/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier {
  int _countNumber = 0;
  bool _isDarkMode = false;

  HomeViewModel({required isDarkMode}) {
    _isDarkMode = isDarkMode;
  }

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

  void changeTheme(BuildContext context) async {
    _isDarkMode = await Cache.readData('isDarkMode') as bool? ?? false;

    _isDarkMode = !_isDarkMode;

    Provider.of<ThemeProvider>(context, listen: false).setThemeMode(isDarkMode);
  }
}
