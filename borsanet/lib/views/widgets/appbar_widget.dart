import 'package:borsanet/app/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool transparentBackground;
  final bool hideProfile;
  const AppBarWidget(
      {super.key,
      required this.title,
      this.transparentBackground = false,
      this.hideProfile = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: transparentBackground ? Colors.transparent: null,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        if(!hideProfile)
          IconButton(onPressed: () => context.push(AppRoutes.profile), icon: const Icon(Icons.person))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}
