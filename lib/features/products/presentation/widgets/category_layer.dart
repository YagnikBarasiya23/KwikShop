import 'package:flutter/material.dart';

import '../../../categories/domain/entities.dart';

class CategoryLayer extends StatelessWidget {
  final Categories currentCategory;
  final ValueChanged<Categories> onCategoryTap;
  final List<Categories> _categories = Categories.values;

  const CategoryLayer({
    Key? key,
    required this.currentCategory,
    required this.onCategoryTap,
  }) : super(key: key);

  Widget _buildCategory(Categories category, BuildContext context) {
    final String categoryString =
        category.toString().replaceAll('Categories.', '').toUpperCase();
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onCategoryTap(category),
      child: category == currentCategory
          ? Column(
              children: <Widget>[
                const SizedBox(height: 16.0),
                Text(
                  categoryString,
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14.0),
                Container(
                  width: 70.0,
                  height: 2.0,
                  color: theme.colorScheme.onSecondary,
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                categoryString,
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: Colors.amber.shade100.withAlpha(153)),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 40.0),
        color: theme.colorScheme.secondary,
        child: ListView(
          children: _categories
              .map(
                (Categories c) => _buildCategory(c, context),
              )
              .toList(),
        ),
      ),
    );
  }
}
