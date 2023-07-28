import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Icon(icon, color: colorScheme.primary, size: 30),
      title: Text(title,
          style: textTheme.labelLarge!
              .copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5,color: colorScheme.onSurface)),
    );
  }
}
