
import 'package:borsanet/services/api_service.dart';
import 'package:borsanet/services/preferences_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingletonAsync<PreferencesService>(
    () async => PreferencesService(prefs: await SharedPreferences.getInstance()),
  );

  locator.registerLazySingleton(() => ApiService());

  // PreferencesService'in tamamen hazır olmasını bekle
  await locator.isReady<PreferencesService>();
}
