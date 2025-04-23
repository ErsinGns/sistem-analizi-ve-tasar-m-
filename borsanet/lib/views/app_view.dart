import 'package:borsanet/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        indicatorColor: Colors.transparent,
        onDestinationSelected: _goBranch,
        destinations: [
          _menuItem(context,
              index: 0, icon: Icons.newspaper, label: S.of(context).News),
          _menuItem(context,
              index: 1, icon: Icons.person, label: S.of(context).Analyst),
          _menuItem(context,
              index: 2, icon: Icons.favorite, label: S.of(context).Favourites),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required int index,
    required String label,
    required IconData icon,
  }) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: navigationShell.currentIndex == index
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.tertiary,
      ),
      label: label,
    );
  }
}
