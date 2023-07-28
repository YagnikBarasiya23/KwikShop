import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kwikshop/core/shared/snackbar.dart';
import 'package:kwikshop/features/cart/presentation/bloc/cart_cubit.dart';
import '../../domain/entities/products.dart';

class ProductsLayer extends StatelessWidget {
  const ProductsLayer({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) => _ProductCard(
            product: products[index],
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter =
        NumberFormat.simpleCurrency(decimalDigits: 0, locale: "en_IN");
    final ThemeData theme = Theme.of(context);
    return Card(
      elevation: 2,
      surfaceTintColor: theme.colorScheme.surface,
      color: theme.colorScheme.surface,
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        height: 200,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 10, left: 11, right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: CachedNetworkImageProvider(product.productImage),
                        width: 90,
                        height: 90,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        product.productName.toString(),
                        style: theme.textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${formatter.format(product.productPrice)}/${product.productAmount}",
                        style: theme.textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<CartCubit>().add(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        appSnackBar("Your item is add successfully"),
                      );
                    },
                    child: Icon(
                      Icons.add_circle,
                      size: 30,
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
