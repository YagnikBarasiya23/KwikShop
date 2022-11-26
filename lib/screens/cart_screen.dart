import 'package:badges/badges.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kwikshop/body_widgets/navigation_bar.dart';
import 'package:kwikshop/models/cart_controller.dart';
import 'package:kwikshop/models/product_model.dart';
import 'package:kwikshop/refactors/constants.dart';
import 'package:kwikshop/refactors/widgets.dart';
import 'package:kwikshop/screens/add_detail_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CartScreen extends StatefulWidget {
  CartScreen({this.shopName});
  final String? shopName;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('Cart');
  String product = '';
  String image = '';
  String price = '';
  String quantity = '';

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

  Icon? icon;
  double elevation = 0;
  Color colour = Colors.grey.shade100;

  checkMark() {
    setState(() {
      if ((icon == null && elevation == 0 && colour == Colors.grey.shade100)) {
        icon = const Icon(
          CupertinoIcons.checkmark_alt,
          color: Color(0xFFF26bf47),
        );
        colour = Colors.white;
        elevation = 5;
      } else {
        icon = null;
        elevation = 0;
        colour = Colors.grey.shade100;
      }
    });
  }

  int activeIndex = 0;
  final CartController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('${widget.shopName}', style: kTextStyleHeaders),
              elevation: 0.5,
              iconTheme: const IconThemeData(color: Colors.black),
              flexibleSpace: Container(
                color: Colors.grey.shade100,
              ),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              height: 260,
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
                                      .productname
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
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 3, left: 18, right: 4, bottom: 6),
                                child: Text(
                                  'Delivery Address',
                                  style: kTextStyleHeaders,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.to(() => DetailsScreen(flag: flag = 1),
                                      transition: Transition.cupertino);
                                },
                                icon: Icon(
                                  CupertinoIcons.pencil_circle_fill,
                                  color: Colors.amber.shade700,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: AddressContainer(
                              index: 0,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 18, right: 4, bottom: 6),
                            child: Text(
                              'Payment Method',
                              style: kTextStyleHeaders,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Badge(
                              elevation: elevation,
                              badgeColor: colour,
                              badgeContent: icon,
                              animationType: BadgeAnimationType.fade,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    flag = 1;
                                  });
                                  checkMark();
                                },
                                child: Container(
                                  height: 102,
                                  margin: const EdgeInsets.all(5),
                                  decoration:
                                      kContainerDecoration.copyWith(boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 10),
                                        blurRadius: 5,
                                        color: kShadowColor.withOpacity(0.23))
                                  ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(36.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.moneyBill1,
                                              size: 30,
                                              color: Color(0xFF64C41C),
                                            ),
                                            const SizedBox(width: 30),
                                            Text('Cash on Delivery',
                                                style: kTextStyleLarge.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 18, right: 18, bottom: 6),
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
                                            color: Colors.amber.shade700)),
                                    Text('${_controller.Total}rs',
                                        style: kTextStyleSmallBold.copyWith(
                                            color: Colors.amber.shade700)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  child:
                                      Center(child: button('Place Order', 330)),
                                  onTap: () {
                                    if (flag == 0) {
                                      Get.snackbar(
                                        'Cannot continue',
                                        'Please select address and payment options',
                                        duration: const Duration(seconds: 2),
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: const EdgeInsets.all(7),
                                      );
                                    } else {
                                      Alert(
                                          context: context,
                                          buttons: [
                                            DialogButton(
                                              onPressed: () async {
                                                Get.offAll(() => NaviBar(),
                                                    transition:
                                                        Transition.cupertino);
                                                _controller.product.clear();
                                              },
                                              color: Colors.amber.shade700,
                                              radius: const BorderRadius.all(
                                                  Radius.circular(20)),
                                              child: const Text('Back to Home'),
                                            ),
                                          ],
                                          image: const Image(
                                            image: AssetImage(
                                                'images/success.png'),
                                            width: 300,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          ),
                                          title: 'Order Successful',
                                          desc:
                                              'Thank you so much for your order',
                                          style: const AlertStyle(
                                            animationType: AnimationType.shrink,
                                            titleStyle: kTextStyleLarge,
                                          ),
                                          closeFunction: () {
                                            Get.back();
                                          }).show();

                                      _databaseReference
                                          .child(currentId)
                                          .child('0')
                                          .child('TotalPrice')
                                          .set(_controller.Total);
                                      _databaseReference
                                          .child(currentId)
                                          .child('0')
                                          .child('Date')
                                          .set(DateFormat('dd-MM-yyyy')
                                              .format(DateTime.now()));
                                    }
                                  },
                                ),
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
    margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 0),
    decoration: kContainerDecoration.copyWith(boxShadow: [
      BoxShadow(
          offset: const Offset(0, 10),
          blurRadius: 5,
          color: kShadowColor.withOpacity(0.23))
    ]),
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
                child: Icon(CupertinoIcons.plus_circle_fill,
                    color: Colors.amber.shade700)),
            const SizedBox(width: 5),
            Text('$quantity',
                style: kTextStyleSmall.copyWith(color: Colors.black)),
            const SizedBox(width: 5),
            GestureDetector(
                onTap: () {
                  controller.removeProducts(product);
                },
                child: Icon(CupertinoIcons.minus_circle_fill,
                    color: Colors.amber.shade700)),
          ],
        ),
      ],
    ),
  );
}
