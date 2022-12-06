// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikshop/body_widgets/header_widget.dart';
import 'package:kwikshop/components/profile_tile.dart';
import 'package:kwikshop/constants.dart';

import 'package:kwikshop/screens/resetpassword_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Account Setting', style: kTextStyleHeaders),
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
              child: Stack(
                children: [
                  SizedBox(
                      height: 80,
                      child: HeaderWidget(
                        showIcon: false,
                        height: 80,
                      )),
                  Column(
                    children: [
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.all(26.0),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => ResetPasswordScreen(),
                                      transition: Transition.cupertino);
                                },
                                child: tile('Reset Password',
                                    CupertinoIcons.lock_rotation)),
                            GestureDetector(
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                                Get.back();
                              },
                              child: tile('Sign Out', FontAwesomeIcons.signOut),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
