import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget topChild;
  final Widget child;
  const DecoratedContainer(
      {super.key, required this.topChild, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        topChild,
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(50),
            ),
          ),
          child: child,
        ),
      ],
    ),
  ),
);

  }
}

