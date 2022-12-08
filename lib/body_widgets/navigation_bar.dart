// ignore_for_file: deprecated_member_use

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/constants.dart';
import 'package:kwikshop/screens/home_screen.dart';
import 'package:kwikshop/screens/profile_screen.dart';
import 'package:kwikshop/screens/search_screen.dart';

class NaviBar extends StatefulWidget {
  @override
  State<NaviBar> createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  int activeIndex = 0;

  final IconData icon1 = FontAwesomeIcons.homeAlt;
  final IconData icon2 = FontAwesomeIcons.search;
  final IconData icon3 = FontAwesomeIcons.solidUser;

  final screens = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (p0) {
          setState(() {
            activeIndex = p0;
          });
        },
        backgroundColor: Colors.white,
        elevation: 2.5,
        currentIndex: activeIndex,
        iconSize: 20,
        selectedItemColor: greenColor,
        selectedLabelStyle: kTextStyleSmall,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(icon1), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(icon2), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(icon3), label: 'Profile'),
        ],
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: activeIndex,
            children: screens,
          ),
        ],
      ),
    );
  }
}
