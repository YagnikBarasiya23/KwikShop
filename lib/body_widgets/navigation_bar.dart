import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
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
  final IconData icon1 = CupertinoIcons.house_fill;
  final IconData icon2 = CupertinoIcons.search;
  final IconData icon3 = CupertinoIcons.person_fill;

  final screens = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        onTap: (p0) {
          setState(() {
            activeIndex = p0;
          });
        },
        backgroundColor: Colors.white,
        elevation: 2.5,
        currentIndex: activeIndex,
        strokeColor: Colors.amber.shade700,
        iconSize: 25,
        selectedColor: const Color(0xFF64C41C),
        items: [
          CustomNavigationBarItem(
            icon: Icon(icon1),
            title: const Text('Home', style: kTextStyleSmall),
          ),
          CustomNavigationBarItem(
            icon: Icon(icon2),
            title: const Text('Search', style: kTextStyleSmall),
          ),
          CustomNavigationBarItem(
            icon: Icon(icon3),
            title: const Text('Profile', style: kTextStyleSmall),
          ),
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
