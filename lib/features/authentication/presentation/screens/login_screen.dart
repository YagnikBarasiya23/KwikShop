import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/snackbar.dart';
import '../../../welcome/presentation/screens/welcome_screen.dart';
import '../bloc/visibility_cubit.dart';
import '../widgets/reponsive_textfield.dart';
import '../widgets/visibility_icon.dart';
import 'registration_screen.dart';
import '../../../../core/shared/app_button.dart';
import '../widgets/header_widget.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  Future<void> loggedIn(BuildContext context) async {
    final validateForm = _formKey.currentState!.validate();
    if (validateForm) {
      try {
        final until = Navigator.popUntil(context, (route) => route.isFirst);
        final go =
            Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        until;
        go;
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackBar(
            e.toString(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              HeaderWidget(
                customClipper: BigClipper(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 270, left: 18, right: 18),
                child: Column(
                  children: [
                    Text(
                      'Hello',
                      style: theme.textTheme.displayMedium!.copyWith(
                          color: colorScheme.onSurface,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'SignIn into your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    ReusedTextField(
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Enter your email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    ReusedTextField(
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      labelText: 'Password',
                      isVisible: context.watch<VisibilityCubit>().state,
                      prefixIcon: Icons.lock,
                      suffixIcon: IconButton(
                        onPressed: () =>
                            context.read<VisibilityCubit>().toggle(),
                        icon: const VisibilityIcon(),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Enter your password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                              context, ResetPasswordScreen.routeName),
                          child: Text(
                            'forget password?',
                            style: textTheme.labelLarge!.copyWith(
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppButton(
                      onPressed: () => loggedIn(context),
                      title: "Sign In",
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New to KwikShop?",
                          style: textTheme.labelLarge!.copyWith(
                            letterSpacing: .5,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            RegistrationScreen.routeName,
                          ),
                          child: Text(
                            'Sign Up',
                            style: textTheme.labelLarge!.copyWith(
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
