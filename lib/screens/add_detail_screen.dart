import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/body_widgets/header_widget.dart';
import 'package:kwikshop/body_widgets/navigation_bar.dart';

import 'package:get/get.dart';
import 'package:kwikshop/components/our_button.dart';
import 'package:kwikshop/constants.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({this.flag = 0});
  final int flag;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool checkedValue = false;
  bool checkboxValue = false;
  String? firstName;
  String? lastName;
  String? pinCode;
  String? homeName;
  String? number;
  String? streetName;

  late DatabaseReference _databaseReference;
  final formKey = GlobalKey<FormState>();
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.ref().child('Details');
    super.initState();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                          'KwikShop',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                        const Text(
                          'Add Details to continue',
                          style: TextStyle(
                              color: Colors.grey, fontFamily: 'Poppins'),
                        ),
                        const SizedBox(height: 55),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
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
                        const SizedBox(height: 20.0),
                        TextFormField(
                          maxLength: 10,
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
                        const SizedBox(height: 20.0),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          decoration: kTextFieldDecoration.copyWith(
                              labelText: "Home Name",
                              hintText: "House No/Flat/No/Floor"),
                          onChanged: (value) {
                            setState(() {
                              homeName = value;
                            });
                          },
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Enter your Home Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLength: 20,
                                textInputAction: TextInputAction.done,
                                decoration: kTextFieldDecoration.copyWith(
                                    labelText: "Street Name",
                                    hintText: "Society/Street Name"),
                                onChanged: (value) {
                                  setState(() {
                                    streetName = value;
                                  });
                                },
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Enter your Street Name';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                maxLength: 6,
                                textInputAction: TextInputAction.done,
                                decoration: kTextFieldDecoration.copyWith(
                                    labelText: "Pincode",
                                    hintText: "Enter your pincode"),
                                onChanged: (value) {
                                  setState(() {
                                    pinCode = value;
                                  });
                                },
                                validator: (value) {
                                  if (value != null && value.length < 6) {
                                    return 'Pincode should of 6 digit';
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        GestureDetector(
                          child: button('Save', 300),
                          onTap: () async {
                            final validateForm =
                                formKey.currentState!.validate();

                            if (validateForm) {
                              if (widget.flag == 0) {
                                Get.off(() => NaviBar(),
                                    transition: Transition.cupertino);
                                Map<String, String> details = {
                                  'HomeName': homeName.toString(),
                                  'StreetName': streetName.toString(),
                                  'FirstName': firstName.toString().trim(),
                                  'LastName': lastName.toString().trim(),
                                  'Number': number.toString(),
                                  'Pincode': pinCode.toString(),
                                  'UserID': currentUser.toString(),
                                };
                                _databaseReference
                                    .child(currentUser.toString())
                                    .child(index.toString())
                                    .set(details);
                              } else {
                                Get.back();

                                Map<String, String> details = {
                                  'HomeName': homeName.toString(),
                                  'StreetName': streetName.toString(),
                                  'FirstName': firstName.toString().trim(),
                                  'LastName': lastName.toString().trim(),
                                  'Number': number.toString(),
                                  'Pincode': pinCode.toString(),
                                  'UserID': currentUser.toString(),
                                };
                                _databaseReference
                                    .child(currentUser.toString())
                                    .child(index.toString())
                                    .set(details);
                              }
                            }
                          },
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
