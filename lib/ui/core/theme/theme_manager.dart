import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';

class AppTheme {
  ThemeData? light;
  ThemeData? dark;

  AppTheme([
    this.light,
    this.dark,
  ]) {
    light = light ??
        ThemeData(
          brightness: Brightness.light,
          primarySwatch: AppColors.teal,
          scaffoldBackgroundColor: const Color.fromARGB(255, 222, 255, 252),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: AppColors.teal,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(color: Colors.white),
            displayMedium: TextStyle(color: Colors.white),
            displaySmall: TextStyle(color: Colors.white),
            headlineLarge: TextStyle(color: Colors.white),
            headlineMedium: TextStyle(color: Colors.white),
            headlineSmall: TextStyle(color: Colors.white),
            titleLarge: TextStyle(color: Colors.white),
            titleMedium: TextStyle(color: Colors.white),
            titleSmall: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
            labelLarge: TextStyle(color: Colors.white),
            labelMedium: TextStyle(color: Colors.white),
            labelSmall: TextStyle(color: Colors.white),
          ),
          navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: AppColors.teal,
          ),
          popupMenuTheme: const PopupMenuThemeData(
            color: Color.fromARGB(255, 11, 238, 250),
            elevation: 15,
            enableFeedback: true,
          ),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Color.fromARGB(255, 213, 247, 249),
            elevation: 10,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.teal,
            selectedItemColor: Colors.white,
            elevation: 10,
            showSelectedLabels: true,
          ),
          bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.teal),
          useMaterial3: true,
          dialogTheme: const DialogTheme(
            backgroundColor: AppColors.space,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            contentTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        );

    dark = dark ??
        ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.yellow,
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.white,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(color: Colors.white),
            displayMedium: TextStyle(color: Colors.white),
            displaySmall: TextStyle(color: Colors.white),
            headlineLarge: TextStyle(color: Colors.white),
            headlineMedium: TextStyle(color: Colors.white),
            headlineSmall: TextStyle(color: Colors.white),
            titleLarge: TextStyle(color: Colors.white),
            titleMedium: TextStyle(color: Colors.white),
            titleSmall: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
            labelLarge: TextStyle(color: Colors.white),
            labelMedium: TextStyle(color: Colors.white),
            labelSmall: TextStyle(color: Colors.white),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.space,
            selectedItemColor: AppColors.teal,
            elevation: 10,
            showSelectedLabels: true,
          ),
          useMaterial3: true,
          dialogTheme: const DialogTheme(
            backgroundColor: AppColors.space,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            contentTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
  }

  ThemeData get lightTheme => light!;
  ThemeData get darkTheme => dark!;

  LinearGradient get linearGradient => LinearGradient(
        begin: Alignment.topLeft, // Inicio del degradado
        end: Alignment.bottomRight, // Fin del degradado
        colors: [
          Color(0xFF54C0CC), // Azul claro
          Color(0xFF7EA08E), // Verde medio
        ],
      );

  LinearGradient get darkGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF232526), // Gris oscuro
          Color(0xFF414345), // Gris más claro
        ],
      );

  AppTheme copyWith({
    ThemeData? light,
    ThemeData? dark,
  }) {
    return AppTheme(
      light ?? this.light,
      dark ?? this.dark,
    );
  }
}
