// ignore_for_file: deprecated_member_use
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikshop/body_widgets/navigation_bar.dart';
import 'package:kwikshop/components/our_button.dart';
import 'package:kwikshop/constants.dart';
import 'package:kwikshop/models/cart_controller.dart';
import 'package:kwikshop/models/product_model.dart';
import 'package:kwikshop/screens/checkout_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CartScreen extends StatefulWidget {
  CartScreen({this.shopName});
  final String? shopName;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late String product;
  late String image;
  late String price;
  late String quantity;

  final CartController _controller = Get.find();
  late final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('Cart');
  final currentId = FirebaseAuth.instance.currentUser!.uid;
  setJson(int length) {
    _databaseReference
        .child(currentId)
        .child('0')
        .child('ShopName')
        .set({'ShopName': widget.shopName});

    _databaseReference
        .child(currentId)
        .child('0')
        .child('Items')
        .child(length.toString())
        .set({
      'Product': product,
      'Image': image,
      'Price': price,
      'Quantity': quantity,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('${widget.shopName}', style: kTextStyleHeaders),
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
            ),
            SliverToBoxAdapter(
              child: _controller.product.length == 0
                  ? Column(
                      children: [
                        const SizedBox(height: 200),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: const Image(
                            image: AssetImage('images/emptycart.png'),
                          ),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 520,
                            width: double.maxFinite,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  price = _controller.productSubTotal[index]
                                      .toString();
                                  image = _controller.product.keys
                                      .toList()[index]
                                      .image
                                      .toString();
                                  product = _controller.product.keys
                                      .toList()[index]
                                      .productName
                                      .toString();
                                  quantity = _controller.product.values
                                      .toList()[index]
                                      .toString();
                                  setJson(index);

                                  return cartCatalog(
                                      index,
                                      _controller,
                                      _controller.product.values
                                          .toList()[index],
                                      _controller.product.keys.toList()[index]);
                                },
                                itemCount: _controller.product.length,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 25, right: 25, bottom: 6),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Delivery Fee',
                                        style: kTextStyleLarge),
                                    Text('Free', style: kTextStyleSmallBold),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total',
                                        style: kTextStyleLarge.copyWith(
                                            color: mainColor)),
                                    Text('${_controller.Total}rs',
                                        style: kTextStyleSmallBold.copyWith(
                                            color: mainColor)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Center(
                                    child: button(
                                  'Checkout',
                                  330,
                                  () => Get.off(() => CheckoutScreen(),
                                      transition: Transition.cupertino),
                                )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

int flag = 0;

Widget cartCatalog(
    int index, CartController controller, int quantity, Products product) {
  return Container(
    height: 90,
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.all(5),
    decoration: kContainerDecoration,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image(
                image: NetworkImage(product.image.toString()),
                width: 60,
                height: 60),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.productName.toString(),
                    style: kTextStyleHeaders.copyWith(
                        fontSize: 21, color: Colors.black)),
                Text('${controller.productSubTotal[index].toString()}rs',
                    style: kTextStyleLarge.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black))
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () {
                  controller.addProducts(product);
                },
                child: Icon(
                  Icons.add_circle,
                  color: mainColor,
                  size: 20,
                )),
            const SizedBox(width: 5),
            Text('$quantity',
                style: kTextStyleSmallBold.copyWith(color: Colors.black)),
            const SizedBox(width: 5),
            GestureDetector(
                onTap: () {
                  controller.removeProducts(product);
                },
                child: Icon(
                  Icons.remove_circle,
                  color: mainColor,
                  size: 20,
                )),
          ],
        ),
      ],
    ),
  );
}
