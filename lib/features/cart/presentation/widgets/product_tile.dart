import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../products/domain/entities/products.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.image,
    required this.product,
    required this.quantity,
    required this.state,
    required this.index,
    required this.productSubTotal,
    required this.onAdd,
    required this.onRemove,
  });

  final String image;
  final Map<Product, dynamic> state;
  final int index;
  final String product;
  final int quantity;
  final List<double> productSubTotal;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final NumberFormat formatter =
        NumberFormat.simpleCurrency(decimalDigits: 0, locale: "en_IN");
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: image,
        height: 40,
        width: 40,
      ),
      title: Text(
        product,
        style:
            textTheme.titleMedium!.copyWith(color: theme.colorScheme.onSurface),
      ),
      subtitle: Text(
        formatter.format(productSubTotal[index]),
        style: TextStyle(color: theme.colorScheme.onSurface),
      ),
      trailing: FittedBox(
        child: Row(
          children: [
            IconButton(
              onPressed: onAdd,
              icon: Icon(
                Icons.add_circle,
                color: theme.colorScheme.tertiary,
              ),
            ),
            Text(
              quantity.toString(),
              style: textTheme.titleMedium!
                  .copyWith(color: theme.colorScheme.onSurface),
            ),
            IconButton(
              onPressed: onRemove,
              icon: Icon(
                Icons.remove_circle,
                color: theme.colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
