import 'package:flutter/material.dart';
import '../../../../core/shared/app_cached_network_image.dart';
import '../../data/models/categories_model.dart';
import '../screens/catergory_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final CategoriesModel category = CategoriesModel.getCategory[index];
    final String categoryName = category.category
        .toString()
        .replaceAll('Categories.', '')
        .toUpperCase();
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, CategoryScreen.routeName,
          arguments: category.category),
      child: SizedBox(
        width: 200,
        height: 83,
        child: Card(
          margin: const EdgeInsets.all(5),
          color: category.color,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryName,
                  style: textTheme.labelSmall!.copyWith(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CachedImage(
                      imageUrl: category.image,
                      width: 50,
                      height: 40,
                      isIcon: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
