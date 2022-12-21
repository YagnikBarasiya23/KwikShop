// ignore_for_file: deprecated_member_use

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

  final IconData icon1 = Icons.home;
  final IconData icon2 = Icons.search;

  final IconData icon3 = Icons.person;

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
        backgroundColor: Colors.grey.shade100,
        elevation: 2.5,
        currentIndex: activeIndex,
        iconSize: 30,
        selectedItemColor: greenColor,
        selectedLabelStyle: kTextStyleSmall,
        type: BottomNavigationBarType.fixed,
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
