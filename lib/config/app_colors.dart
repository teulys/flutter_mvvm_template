import 'package:flutter/material.dart';

class AppColors {
  static const int _black = 0xFF222831;
  static const MaterialColor black = MaterialColor(_black, {
    500: Color(_black),
  });

  static const int _space = 0xFF393E46;
  static const MaterialColor space = MaterialColor(_space, {
    400: Color(0xFF424242),
    500: Color(_space),
  });

  static const int _grey = 0xEEEEEEEE;
  static const MaterialColor grey = MaterialColor(_grey, {
    500: Color(_grey),
  });

  static const int _teal = 0xFF00ADB5;
  static const MaterialColor teal = MaterialColor(
    _teal,
    <int, Color>{
      50: Color(0xFFE0F7FA),
      100: Color(0xFFB2EBF2),
      200: Color(0xFF80DEEA),
      300: Color(0xFF4DD0E1),
      400: Color(0xFF26C6DA),
      500: Color(_teal),
      600: Color(0xFF00ACC1),
      700: Color(0xFF0097A7),
      800: Color(0xFF00838F),
      900: Color(0xFF006064),
    },
  );

  static const Color blueLight = Color(0xFF54C0CC); // #54C0CC
  static const Color blueDark = Color(0xFF3F5F9); // #3F5F9
  static const Color greenLight = Color(0xFF7EA08E); // #7EA08E
  static const Color limeLight = Color(0xFFDCD964); // #DCD964
  static const Color greenDark = Color(0xFF213502); // #213502

  // Modo Dark
  static const Color darkBlue = Color(0xFF2B4B55); // Azul oscuro adaptado
  static const Color darkDarkBlue = Color(0xFF25374D); // Azul profundo
  static const Color darkGreen = Color(0xFF546E60); // Verde oscuro adaptado
  static const Color darkLime = Color(0xFFA1A650); // Verde lima más oscuro
  static const Color darkDarkGreen = Color(0xFF141D02); // Verde más oscuro

  // Gradients
  static const Gradient blueGreenGradient = LinearGradient(
    colors: [blueLight, greenLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient limeGreenGradient = LinearGradient(
    colors: [limeLight, greenDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradients - Dark Mode
  static const Gradient darkBlueGreenGradient = LinearGradient(
    colors: [darkBlue, darkGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient darkLimeGreenGradient = LinearGradient(
    colors: [darkLime, darkDarkGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
