import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Dark mode toggle action
  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    // Save the value to secure storage
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  // Init method of provider
  Future<void> initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // Check if there is a saved preference for the theme
    if (prefs.containsKey('isDarkMode')) {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    } else {
      // If not, get the system's theme and set accordingly using PlatformDispatcher
      final brightness = PlatformDispatcher.instance.platformBrightness;
      _isDarkMode = brightness == Brightness.dark;
    }
    notifyListeners();
  }
}
