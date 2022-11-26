import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/body_widgets/navigation_bar.dart';
import 'package:kwikshop/screens/login_screen.dart';
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NaviBar();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
