import 'package:my_flutter_mvvm_template/ui/core/theme/theme_manager.dart';
import 'package:my_flutter_mvvm_template/ui/core/theme/theme_provider.dart';

class ThemeProvider extends BaseThemeProvider {
  int _index = 0;

  get index => _index;

  setNavIndex(int index) {
    _index = index;
    if (index != 0) {
      notifyListeners();
    }
  }
}

class MyTheme extends AppTheme {}
