import 'package:borsanet/app/locator.dart';
import 'package:borsanet/services/preferences_service.dart';
import 'package:flutter/material.dart';

class AppLanguage extends ChangeNotifier {
  late Locale _Language;
  String key = "language"; // true en

  AppLanguage() {
    bool? userPreference = locator<PreferencesService>().getSettings(key);
    if (userPreference == null) {
      final Locale platformLanguage =
          WidgetsBinding.instance.platformDispatcher.locale;
          print(platformLanguage.languageCode);
      _Language =
          platformLanguage.languageCode == "en" ? Locale("en") : Locale("tr");
    } else {
      _Language = userPreference ? Locale("en") : Locale("tr");
    }
  }
  Locale get current => _Language;

  void toggleLanguage() {
    bool isEn = _Language == Locale("en");
    locator<PreferencesService>().saveSettings(key, !isEn);
    _Language = isEn ? Locale("tr") : Locale("en");
    notifyListeners();
  }
}
