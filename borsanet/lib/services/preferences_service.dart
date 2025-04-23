import 'package:shared_preferences/src/shared_preferences_legacy.dart';

class PreferencesService {
  final SharedPreferences prefs;
  PreferencesService({required this.prefs});
  
  void saveSettings(String key, bool value) async{
    await prefs.setBool(key, value);
  }

  bool? getSettings(String key) {
    return prefs.getBool(key);
  }


}