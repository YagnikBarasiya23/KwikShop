import 'package:flutter/material.dart';

import '../widget/category_card.dart';
import '../widget/search_button.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  static const String routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              Card(
                child: ListTile(
                  onTap: () => showSearch(
                    context: context,
                    delegate: SearchButton(),
                  ),
                  leading: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 10),
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
