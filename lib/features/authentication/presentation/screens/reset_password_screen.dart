import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/core/shared/app_button.dart';
import 'package:kwikshop/core/shared/snackbar.dart';
import 'package:kwikshop/features/authentication/presentation/widgets/header_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});
  static final TextEditingController _email = TextEditingController();
  static const String routeName = '/reset';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              HeaderWidget(customClipper: BigClipper()),
              AppBar(
                title: const Text("Reset Password"),
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                const Text(
                  'KwikShop',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Text(
                  'reset your password',
                  style: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 30.0),
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20.0),
                AppButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _email.text.trim());
                      appSnackBar(
                          "reset password link is successfully been sent");
                    } on FirebaseAuthException catch (e) {
                      appSnackBar(
                        e.toString(),
                      );
                    }
                  },
                  title: 'Reset',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
