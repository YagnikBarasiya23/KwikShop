import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwikshop/features/authentication/presentation/screens/login_screen.dart';
import 'package:kwikshop/features/authentication/presentation/widgets/header_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/shared/app_button.dart';
import '../../../../core/shared/snackbar.dart';
import '../../../welcome/presentation/screens/welcome_screen.dart';
import '../bloc/checkbox_cubit.dart';
import '../bloc/visibility_cubit.dart';
import '../widgets/reponsive_textfield.dart';
import '../widgets/visibility_icon.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});
  static const String routeName = '/register';

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final TextEditingController _emailController = TextEditingController();

  static final TextEditingController _passwordController =
      TextEditingController();

  static final TextEditingController _confirmPasswordController =
      TextEditingController();

  static final TextEditingController _firstNameController =
      TextEditingController();

  static final TextEditingController _lastNameController =
      TextEditingController();

  static final TextEditingController _mobileNumberController =
      TextEditingController();

  static final _firebaseFirestore =
      FirebaseFirestore.instance.collection('ProfileDetails');

  Future<void> _registerUser(BuildContext context, bool isCheck) async {
    final validateForm = _formKey.currentState!.validate();
    if (validateForm) {
      if (isCheck == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackBar("Please accept terms and conditions"),
        );
      } else {
        try {
          final until = Navigator.popUntil(context, (route) => route.isFirst);
          final go =
              Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
          setUserDetails();
          until;
          go;
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackBar(e.toString()),
          );
        }
      }
    }
  }

  void setUserDetails() {
    Map<String, dynamic> details = {
      'FirstName': _firstNameController.text.trim(),
      'LastName': _lastNameController.text.trim(),
      'MobileNumber': _mobileNumberController.text.trim(),
      'UserID': FirebaseAuth.instance.currentUser!.uid.toString(),
    };

    _firebaseFirestore
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('UserDetails')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(details);
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
              HeaderWidget(customClipper: SmallClipper()),
              Padding(
                padding: const EdgeInsets.only(top: 130, left: 18, right: 18),
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: theme.textTheme.displayMedium!.copyWith(
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Get your groceries KWIK',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(color: colorScheme.onSurface),
                            controller: _firstNameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: "First Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: colorScheme.secondary,
                              ),
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Enter your First Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(color: colorScheme.onSurface),
                            controller: _lastNameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: colorScheme.secondary,
                              ),
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Enter your Last Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ReusedTextField(
                      keyboardType: TextInputType.phone,
                      controller: _mobileNumberController,
                      labelText: "Phone Number",
                      prefixIcon: Icons.call,
                      validator: (value) {
                        if (value != null && value.length < 10) {
                          return 'Phone number should of 10 digit';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    ReusedTextField(
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      labelText: "Email address",
                      prefixIcon: Icons.email,
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
                      isVisible: context.watch<VisibilityCubit>().state,
                      controller: _passwordController,
                      labelText: 'Password',
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
                    const SizedBox(height: 10),
                    ReusedTextField(
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.visiblePassword,
                      isVisible: context.watch<VisibilityCubit>().state,
                      controller: _confirmPasswordController,
                      labelText: "Confirm Password",
                      prefixIcon: Icons.lock,
                      suffixIcon: IconButton(
                        onPressed: () =>
                            context.read<VisibilityCubit>().toggle(),
                        icon: const VisibilityIcon(),
                      ),
                      validator: (value) {
                        if (value != null &&
                            !value.contains(_passwordController.text)) {
                          return 'The password does not match';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        BlocBuilder<CheckboxCubit, bool>(
                          builder: (context, state) => Checkbox(
                            activeColor: Colors.black,
                            value: state,
                            onChanged: (value) =>
                                context.read<CheckboxCubit>().toggle(),
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              "I accept all ",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 3),
                            GestureDetector(
                              onTap: () {
                                Uri url = Uri.parse(
                                  'https://pages.flycricket.io/kwikshop/terms.html',
                                );
                                launchUrl(url);
                              },
                              child: Text(
                                'terms and conditions',
                                style: textTheme.labelLarge!.copyWith(
                                  letterSpacing: 1,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    BlocBuilder<CheckboxCubit, bool>(
                      builder: (context, state) => AppButton(
                        onPressed: () => _registerUser(context, state),
                        title: 'Sign Up',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Joined us before?",
                          style: textTheme.labelLarge!.copyWith(
                            letterSpacing: .5,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            LoginScreen.routeName,
                          ),
                          child: Text(
                            'Sign In',
                            style: textTheme.labelLarge!.copyWith(
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
