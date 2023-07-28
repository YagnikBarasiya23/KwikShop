import 'package:flutter/material.dart';

import '../widget/category_card.dart';
import '../widget/search_button.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  static const String routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Search', style: textTheme.headlineSmall),
              const SizedBox(height: 5),
              const SearchButton(),
              const SizedBox(height: 10),
              Text('Categories', style: textTheme.headlineSmall),
              const SizedBox(height: 5),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.8,
                children: List.generate(
                  12,
                  (index) => CategoryCard(index: index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
