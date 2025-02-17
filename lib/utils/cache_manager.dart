import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    bool? initIsDarkMode = prefs.getBool("isDarkMode");
    if (initIsDarkMode == null) {
      prefs.setBool("isDarkMode", false);
    }
  }

  static Future<void> saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      log("Invalid Type");
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
