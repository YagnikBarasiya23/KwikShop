import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:kwikshop/features/profile/presentation/widgets/profile_tile.dart';

import '../../../welcome/presentation/screens/welcome_screen.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});
  static const String routeName = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ResetPasswordScreen.routeName),
              child: const Card(
                child: ProfileTile(
                  title: 'Reset Password',
                  icon: Icons.lock_reset,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacementNamed(
                    context, WelcomeScreen.routeName);
              },
              child: const Card(
                child: ProfileTile(
                  title: 'Sign Out',
                  icon: Icons.logout,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
