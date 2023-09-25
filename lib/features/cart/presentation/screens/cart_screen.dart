import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kwikshop/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../../assets_gen.dart';
import '../../../../core/shared/app_button.dart';
import '../../../../injection_container.dart';
import '../../../checkout/presentation/screens/checkout_screen.dart';
import '../../domain/usecase/cart_usecase.dart';
import '../bloc/orderid_cubit.dart';
import '../widgets/product_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.storeName});

  static const String routeName = '/cart';
  final String storeName;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final NumberFormat formatter =
        NumberFormat.simpleCurrency(decimalDigits: 0, locale: "en_IN");
    final cartBloc = context.read<CartBloc>();
    return Scaffold(
      appBar: AppBar(title: Text(storeName)),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoad) {
            final cart = state.cart.cart;
            return cart.isEmpty
                ? Center(
                    child: Assets.icons.emptyCart.image(),
                  )
                : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final String product =
                                cart.keys.toList()[index].productName;
                            final String image =
                                cart.keys.toList()[index].productImage;
                            final int quantity = cart.values.toList()[index];
                            final double price =
                                cart.keys.toList()[index].productPrice;

                            context
                                .read<OrderIdCubit>()
                                .setOrderId(orderId.get<String>());
                            cartInjection.get<CartUseCase>().call(
                                  params: OrderItem(
                                    orderId: orderId.get<String>(),
                                    image: image,
                                    product: product,
                                    quantity: quantity,
                                    index: index + 1,
                                    price: price,
                                  ),
                                );

                            return ProductTile(
                              image: image,
                              index: index,
                              state: cart,
                              product: product,
                              quantity: quantity,
                              productSubTotal: state.cart.productSubTotal,
                              onAdd: () => cartBloc.add(
                                AddItem(
                                  product: cart.keys.toList()[index],
                                ),
                              ),
                              onRemove: () => cartBloc.add(
                                RemoveItem(
                                  product: cart.keys.toList()[index],
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: cart.length,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            elevation: 16,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Grand Total: ${formatter.format(state.cart.grandTotal.round())}",
                                    style: textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: AppButton(
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        CheckoutScreen.routeName,
                                        arguments: [
                                          storeName,
                                          state.cart.grandTotal
                                        ],
                                      ),
                                      title: 'Checkout',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
          } else {
            return const Text("ERROR");
          }
        },
      ),
    );
  }
}
