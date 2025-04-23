import 'package:borsanet/app/language.dart';
import 'package:borsanet/app/locator.dart';
import 'package:borsanet/app/router.dart';
import 'package:borsanet/app/theme.dart';
import 'package:borsanet/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppTheme()),
        ChangeNotifierProvider(create: (context) => AppLanguage()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppTheme, AppLanguage>(
      builder:(context, themeProvider, languageProvider, child) => MaterialApp.router(
        localizationsDelegates: const[
          S.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate, 
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: languageProvider.current,

        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: themeProvider.theme,
      ),
    );
  }
}

// flutter pub run intl_utils:generate