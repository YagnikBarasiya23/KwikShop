import 'package:flutter/material.dart';
import '../../../../core/shared/app_button.dart';
import '../../../authentication/presentation/screens/login_screen.dart';
import '../widgets/animated_background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const AnimatedBackground(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  WelcomeConstants.title,
                  textAlign: TextAlign.center,
                  style: textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  WelcomeConstants.desc,
                  textAlign: TextAlign.center,
                  style: textTheme.labelLarge!.copyWith(
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 30),
                AppButton(
                  title: 'Get Started',
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeConstants {
  static const String title = 'We deliver\ngrocery at your doorstep';
  static const String desc =
      'Groceer gives you fresh vegetables and fruits, Order fresh items from groceer';
}
