import 'package:flutter/material.dart';
import 'package:kwikshop/features/categories/domain/entities.dart';

class CategoriesModel {
  final String image;
  final Categories category;
  final Color color;

  const CategoriesModel(
      {required this.image, required this.category, required this.color});
  static List<CategoriesModel> getCategory = [
    CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/3194/3194591.png',
      category: Categories.fruits,
      color: Colors.green.shade100,
    ),
    CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/2153/2153786.png',
      category: Categories.vegetables,
      color: Colors.orange.shade200,
    ),
    CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/2553/2553691.png',
      category: Categories.snacks,
      color: Colors.yellow.shade400,
    ),
    CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/2403/2403379.png',
      category: Categories.meats,
      color: Colors.red.shade400,
    ),
    CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/3081/3081967.png',
      category: Categories.bakery,
      color: Colors.brown.shade400,
    ),
    CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/994/994928.png',
      category: Categories.cleaners,
      color: Colors.blue.shade100,
    ),
    CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/3157/3157358.png',
      category: Categories.frozenFoods,
      color: Colors.pink.shade100,
    ),
    CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/5532/5532424.png',
      category: Categories.personalCare,
      color: Colors.purple.shade100,
    ),
    CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/3050/3050153.png',
      category: Categories.beverages,
      color: Colors.amber.shade400,
    ),
    const CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/3050/3050158.png',
      category: Categories.dairy,
      color: Colors.white,
    ),
    CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/3082/3082037.png',
      category: Categories.cannedGoods,
      color: Colors.teal.shade400,
    ),
    const CategoriesModel(
      image: 'https://cdn-icons-png.flaticon.com/512/2674/2674638.png',
      category: Categories.foodGrains,
      color: Colors.grey,
    ),
  ];
}
