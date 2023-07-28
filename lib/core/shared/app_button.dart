import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
  });
  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primary;
    final buttonStyle = theme.textTheme.titleMedium!.copyWith(
      fontSize: 17,
      letterSpacing: 1,
      color: theme.colorScheme.onPrimary,
    );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        backgroundColor: backgroundColor,
        minimumSize: const Size(200, 45),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(title, style: buttonStyle),
    );
  }
}
