import 'package:flutter/material.dart';

import 'app_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.onPressed,
    required this.image,
    required this.title,
    required this.desc,
    required this.animation,
  });
  final VoidCallback onPressed;
  final Widget image;
  final String title;
  final String desc;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return ScaleTransition(
      scale: Tween<double>(begin: .5, end: 1).animate(animation),
      child: FadeTransition(
        opacity: Tween<double>(begin: .5, end: 1).animate(animation),
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              image,
              Text(
                title,
                style: textTheme.titleLarge!,
              ),
              const SizedBox(height: 10),
              Text(
                desc,
                style: textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              AppButton(
                onPressed: onPressed,
                title: "Back to Home",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
