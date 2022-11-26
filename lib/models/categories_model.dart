import 'package:flutter/material.dart';

class CategoriesClass {
  final String image;
  final String name;
  final Color color;

  CategoriesClass(
      {required this.image, required this.name, required this.color});
  static List<CategoriesClass> getCategory = [
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/3194/3194591.png',
        name: 'Fruits',
        color: Colors.green.shade100),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/2153/2153786.png',
        name: 'Vegetables',
        color: Colors.orange.shade200),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/2553/2553691.png',
        name: 'Snacks',
        color: Colors.yellow.shade400),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/2403/2403379.png',
        name: 'Meats',
        color: Colors.red.shade400),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/3081/3081967.png',
        name: 'Bakery',
        color: Colors.brown.shade400),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/994/994928.png',
        name: 'Cleaners',
        color: Colors.blue.shade100),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/3157/3157358.png',
        name: 'Frozen Foods',
        color: Colors.pink.shade100),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/5532/5532424.png',
        name: 'Personal Care',
        color: Colors.purple.shade100),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/3050/3050153.png',
        name: 'Beverages',
        color: Colors.amber.shade400),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/3050/3050158.png',
        name: 'Dairy',
        color: Colors.white),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/3082/3082037.png',
        name: 'Canned Goods',
        color: Colors.teal.shade400),
    CategoriesClass(
        image: 'https://cdn-icons-png.flaticon.com/512/2674/2674638.png',
        name: 'Food Grains',
        color: Colors.grey),
  ];
}
