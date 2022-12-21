import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/body_widgets/header_widget.dart';
import 'package:kwikshop/body_widgets/navigation_bar.dart';
import 'package:kwikshop/components/our_button.dart';
import 'package:kwikshop/constants.dart';
import 'package:get/get.dart';
import 'package:kwikshop/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool checkedValue = false;
  late String email;
  late String password;
  bool checkboxValue = false;
  bool visiblePassword = true;
  late String confirmPassword;
  String? firstName;
  String? lastName;
  String? number;
  final formKey = GlobalKey<FormState>();
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("Details");

  @override
  void dispose() {
    Map<String, String> details = {
      'FirstName': firstName.toString().trim(),
      'LastName': lastName.toString().trim(),
      'Number': number.toString(),
      'UserID': FirebaseAuth.instance.currentUser!.uid.toString(),
    };
    _databaseReference
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .child(0.toString())
        .set(details);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            SizedBox(
                height: 150, child: HeaderWidget(showIcon: false, height: 150)),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 132,
                        ),
                        const Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                        const Text(
                          'Get your groceries KWIK',
                          style: TextStyle(
                              color: Colors.grey, fontFamily: 'Poppins'),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                decoration: kTextFieldDecoration.copyWith(
                                    labelText: "First Name",
                                    hintText: "Enter your firstname"),
                                onChanged: (value) {
                                  setState(() {
                                    firstName = value;
                                  });
                                },
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
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                decoration: kTextFieldDecoration.copyWith(
                                    labelText: "Last Name",
                                    hintText: "Enter your lastname"),
                                onChanged: (value) {
                                  setState(() {
                                    lastName = value;
                                  });
                                },
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
                        const SizedBox(height: 20),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: "Phone Number",
                            hintText: "Enter your Phone Number",
                          ),
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            setState(() {
                              number = value;
                            });
                          },
                          validator: (value) {
                            if (value != null && value.length < 10) {
                              return 'Phone number should of 10 digit';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              labelText: "E-mail address",
                              hintText: "Enter your email"),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Enter your First Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          obscureText: visiblePassword,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: "Password",
                            hintText: "Enter your password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (visiblePassword == true) {
                                    visiblePassword = false;
                                  } else {
                                    visiblePassword = true;
                                  }
                                });
                              },
                              icon: visiblePassword == true
                                  ? const Icon(CupertinoIcons.eye_fill)
                                  : const Icon(CupertinoIcons.eye_slash_fill),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Enter your First Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) {
                            setState(() {
                              confirmPassword = value;
                            });
                          },
                          obscureText: visiblePassword,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: "Confirm Password",
                            hintText: "Confirm Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (visiblePassword == true) {
                                    visiblePassword = false;
                                  } else {
                                    visiblePassword = true;
                                  }
                                });
                              },
                              icon: visiblePassword == true
                                  ? const Icon(CupertinoIcons.eye_fill)
                                  : const Icon(CupertinoIcons.eye_slash_fill),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value != null && !value.contains(password)) {
                              return 'The password does not match';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Row(
                                      children: [
                                        const Text(
                                          "I accept all ",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Poppins'),
                                        ),
                                        GestureDetector(
                                          child: const Text(
                                              "terms and conditions.",
                                              style: kTextStyleSmallBold),
                                          onTap: () {
                                            Uri url = Uri.parse(
                                                'https://pages.flycricket.io/kwikshop/terms.html');
                                            launchUrl(url);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        button(
                          'Sign Up',
                          300,
                          () async {
                            final validateForm =
                                formKey.currentState!.validate();
                            if (validateForm) {
                              if (checkboxValue == false) {
                                Get.snackbar(
                                  'Enable to Register',
                                  'Please accept to our terms and conditions',
                                  duration: const Duration(seconds: 4),
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.all(7),
                                );
                              } else {
                                try {
                                  final newUser = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email.trim(),
                                          password: password);
                                  if (newUser != null) {
                                    Get.off(() => NaviBar(),
                                        transition: Transition.cupertino);
                                  }
                                } on FirebaseAuthException catch (e) {
                                  Get.snackbar(
                                    'Enable to Register',
                                    e.message.toString(),
                                    duration: const Duration(seconds: 4),
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.all(7),
                                  );
                                }
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Joined us before?",
                                style: kTextStyleSmall),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => LoginScreen(),
                                    transition: Transition.cupertino);
                              },
                              child: Text(
                                "Login",
                                style: kTextStyleSmall.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
