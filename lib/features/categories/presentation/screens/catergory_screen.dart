import 'package:flutter/material.dart';
import 'package:kwikshop/features/categories/domain/entities.dart';
import 'package:kwikshop/features/home/domain/usecase/store_usecase.dart';
import 'package:kwikshop/injection_container.dart';
import '../../../home/domain/entities/store.dart';
import '../../../home/presentation/widgets/store_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.category});
  static const String routeName = '/category';
  final Categories category;

  @override
  Widget build(BuildContext context) {
    final String categoryName =
        category.toString().replaceAll('Categories.', '');
    final List<Store> stores =
        storeInjection.get<StoreUseCase>().call(params: category);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
            itemBuilder: (context, index) => StoreCard(store: stores[index]),
            shrinkWrap: true,
            itemCount: stores.length,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
