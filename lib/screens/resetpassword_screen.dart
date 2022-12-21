import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikshop/body_widgets/header_widget.dart';
import 'package:kwikshop/components/our_button.dart';
import 'package:kwikshop/constants.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final int flag = 0;
  final double _headerHeight = 250;
  final Key _formKey = GlobalKey<FormState>();
  late final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.5,
            iconTheme: const IconThemeData(color: Colors.black),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ])),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  SizedBox(
                      height: _headerHeight,
                      child:
                          HeaderWidget(height: _headerHeight, showIcon: false)),
                  SafeArea(
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        margin: const EdgeInsets.fromLTRB(
                            20, 10, 20, 10), // This will be the login form
                        child: Column(
                          children: [
                            const Text(
                              'KwikShop',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                            const Text(
                              'reset your password',
                              style: TextStyle(
                                  color: Colors.grey, fontFamily: 'Poppins'),
                            ),
                            const SizedBox(height: 30.0),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration: kTextFieldDecoration.copyWith(
                                          labelText: 'Email',
                                          hintText: 'Enter your email'),
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.done,
                                    ),
                                    const SizedBox(height: 20.0),
                                  ],
                                )),
                            button(
                              'Reset',
                              300,
                              () async {
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: email.trim());
                                  Get.snackbar(
                                    'Check your mail',
                                    'reset password link is successfully been sent',
                                    duration: const Duration(seconds: 4),
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.all(7),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  Get.snackbar(
                                    'Enter correct email',
                                    e.message.toString(),
                                    duration: const Duration(seconds: 4),
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.all(7),
                                  );
                                }
                              },
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
