import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../../categories/domain/entities.dart';
import '../../domain/usecase/products_usecase.dart';
import '../bloc/current_category_cubit.dart';
import '../widgets/category_layer.dart';
import '../widgets/products_layer.dart';
import '../widgets/two_stack_drop.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.storeName});
  static const String routeName = 'products';
  final String storeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CurrentCategoryCubit, Categories>(
        builder: (context, state) => TwoStackDrop(
          storeName: storeName,
          currentCategory: Categories.all,
          productsLayer: ProductsLayer(
            products:
                productInjection.get<ProductsUseCase>().call(params: state),
          ),
          categoriesLayer: CategoryLayer(
            currentCategory: state,
            onCategoryTap: (value) =>
                context.read<CurrentCategoryCubit>().setCategory(value),
          ),
        ),
      ),
    );
  }
}
