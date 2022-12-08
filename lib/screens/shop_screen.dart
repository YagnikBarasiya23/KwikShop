// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kwikshop/constants.dart';
import 'package:kwikshop/models/cart_controller.dart';
import 'package:kwikshop/models/product_model.dart';
import 'package:kwikshop/screens/cart_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({this.shopName, this.url});
  String? shopName;
  String? url;
  final CartController _controller = Get.put(CartController());
  final CartController _controller1 = Get.find();
  int id = 0;
  int length = 0;
  void setID() {
    if (shopName == 'Emart') {
      id = 0;
      length = 33;
    } else if (shopName == 'Frozen World') {
      id = 1;
      length = 12;
    } else if (shopName == 'Krushna General Store') {
      id = 2;
      length = 9;
    } else if (shopName == 'Vikram Brothers') {
      id = 3;
      length = 9;
    } else if (shopName == 'Dev general store') {
      id = 4;
      length = 15;
    } else if (shopName == 'All in one general store') {
      id = 5;
      length = 12;
    } else if (shopName == 'Umart') {
      id = 6;
      length = 30;
    } else if (shopName == 'Shiv Provision Store') {
      id = 7;
      length = 15;
    } else if (shopName == 'Golden Supermarket') {
      id = 8;
      length = 27;
    } else if (shopName == 'JayMataji General Store') {
      id = 9;
      length = 18;
    }
  }

  @override
  Widget build(BuildContext context) {
    setID();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shadowColor: Colors.black,
            elevation: 2.5,
            expandedHeight: 220,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: leftArrowIcon),
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: AssetImage(url.toString()),
                fit: BoxFit.fill,
              ),
              title: Text(shopName.toString(),
                  style: kTextStyleLarge.copyWith(color: Colors.white)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 12, bottom: 10, left: 10, right: 20),
                child: Badge(
                    elevation: 5,
                    badgeColor: Colors.red,
                    badgeContent:
                        Obx(() => Text('${_controller1.product.length}')),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => CartScreen(shopName: shopName),
                            transition: Transition.cupertino);
                      },
                      child: const Icon(
                        FontAwesomeIcons.cartShopping,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
              ),
            ],
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MasonryGridView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemBuilder: (context, index) {
                return ItemCard(index: index, controller: _controller, id: id);
              },
              itemCount: length,
            ),
          ))
        ],
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  ItemCard({
    required this.index,
    required this.controller,
    required this.id,
  });
  int index;
  CartController controller;
  int id;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  String productName = '';
  int productPrice = 0;
  String image = 'https://wallpaperaccess.com/full/1556608.jpg';
  late final DatabaseReference _databaseReference;

  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
    _readDatabase(widget.index);
    super.initState();
  }

  _readDatabase(int index) {
    _databaseReference
        .child('Stores')
        .child(widget.id.toString())
        .child('items')
        .child(index.toString())
        .child('name')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        productName = databaseEvent.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Stores')
        .child(widget.id.toString())
        .child('items')
        .child(index.toString())
        .child('price')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        productPrice = databaseEvent.snapshot.value as int;
      });
    });
    _databaseReference
        .child('Stores')
        .child(widget.id.toString())
        .child('items')
        .child(index.toString())
        .child('image')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        image = databaseEvent.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.only(top: 5, right: 3, left: 3),
      decoration: kContainerDecoration.copyWith(boxShadow: [
        BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 10,
            color: kShadowColor.withOpacity(0.23))
      ]),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 10, left: 8, right: 8),
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
                        image: NetworkImage(image),
                        width: 110,
                        height: 135,
                        fit: BoxFit.fill),
                    Text(productName,
                        style: kTextStyleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                    Text('${productPrice}rs', style: kTextStyleSmall)
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Products.getProducts.add(Products(
                              image: image,
                              productName: productName,
                              productPrice: productPrice));
                          widget.controller.addProducts(Products
                              .getProducts[Products.getProducts.length - 1]);
                          _databaseReference
                              .child('Cart')
                              .child(FirebaseAuth.instance.currentUser!.uid)
                              .child('0')
                              .remove();
                        },
                        child: Icon(
                          FontAwesomeIcons.circlePlus,
                          size: 30,
                          color: mainColor,
                        )),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
