import 'package:borsanet/app/locator.dart';
import 'package:borsanet/services/preferences_service.dart';
import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  late ThemeMode themeMode;
  String key = "theme"; // true lightTheme

  AppTheme() {
    bool? userPreference = locator<PreferencesService>().getSettings(key);
    if (userPreference == null) {
      final Brightness platformBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      themeMode = platformBrightness == Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark;
    } else {
      themeMode = userPreference ? ThemeMode.light : ThemeMode.dark;
    }
  }

  ThemeData get theme => themeMode == ThemeMode.light ? lightTheme : darkTheme;

  void toggleTheme() {
    bool isLight = themeMode == ThemeMode.light;
    locator<PreferencesService>().saveSettings(key, !isLight);
    themeMode = isLight ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  static ThemeData get lightTheme => ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1E5F74), 
          secondary:
              Color(0xFF88D498),
          surface: Colors.white,
          onSurface: Color(0xFF2B2B2B),
          error: Color(0xFFD32F2F), 
          tertiary: Color(0xFFB0BEC5),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFF1E5F74),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor:
            const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary:
              Color(0xFF4FC3F7), 
          secondary:
              Color(0xFF66BB6A),
          surface: Color(0xFF1E1E1E),
          onSurface: Colors.white,
          error: Color(0xFFFF5252), 
          tertiary: Color(0xFF90A4AE), 
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFF4FC3F7),
          ),
        ),
      );
}
