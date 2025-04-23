import 'package:borsanet/app/language.dart';
import 'package:borsanet/app/theme.dart';
import 'package:borsanet/generated/l10n.dart';
import 'package:borsanet/views/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: S.of(context).Settings, hideProfile: true),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Karanlık Tema'),
              trailing: Switch(
                value: context.watch<AppTheme>().themeMode == ThemeMode.dark,
                onChanged: (v) => context.read<AppTheme>().toggleTheme(),
              ),
              
            ),
            ListTile(
              title: const Text('Türkçe'),
              trailing: Switch(
                value: context.watch<AppLanguage>().current == Locale("tr"),
                onChanged: (v) => context.read<AppLanguage>().toggleLanguage(),
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}