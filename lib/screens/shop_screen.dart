// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
    if (shopName == 'Dmart') {
      id = 0;
      length = 20;
    } else if (shopName == 'Krushna General Store') {
      id = 1;
      length = 6;
    } else if (shopName == 'Vikram Provision Store') {
      id = 2;
      length = 14;
    } else if (shopName == 'Golden Supermarket') {
      id = 3;
      length = 6;
    } else if (shopName == 'Krushna General Store') {
      id = 4;
      length = 12;
    } else if (shopName == 'All in one General Store') {
      id = 5;
      length = 20;
    } else if (shopName == 'Osia Mart') {
      id = 6;
      length = 20;
    } else if (shopName == 'Shiv Provision Store') {
      id = 7;
      length = 20;
    }
  }

  @override
  Widget build(BuildContext context) {
    setID();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
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
                        Icons.shopping_cart,
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
                  return ItemCard(
                      index: index, controller: _controller, id: id);
                },
                itemCount: length,
              ),
            ),
          )
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
  String? productName;
  late int productPrice;
  late String image;
  late String currency;
  late final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  @override
  void initState() {
    _readDatabase(widget.index);
    super.initState();
  }

  _readDatabase(int index) {
    _databaseReference
        .child('Stores')
        .child(widget.id.toString())
        .child('Items')
        .child(index.toString())
        .child('Name')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        productName = databaseEvent.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Stores')
        .child(widget.id.toString())
        .child('Items')
        .child(index.toString())
        .child('Currency')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        currency = databaseEvent.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Stores')
        .child(widget.id.toString())
        .child('Items')
        .child(index.toString())
        .child('Price')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        productPrice = databaseEvent.snapshot.value as int;
      });
    });
    _databaseReference
        .child('Stores')
        .child(widget.id.toString())
        .child('Items')
        .child(index.toString())
        .child('Image')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        image = databaseEvent.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return productName == null
        ? const Center(
            child: CircularProgressIndicator(
              color: greenColor,
            ),
          )
        : Container(
            height: 200,
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.only(top: 5, right: 3, left: 3),
            decoration: kContainerDecoration,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 10, left: 11, right: 12),
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
                            Text(productName.toString(),
                                style: kTextStyleSmall.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )),
                            Text('$currency$productPrice',
                                style: kTextStyleSmall)
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Products.getProducts.add(Products(
                                      image: image,
                                      productName: productName.toString(),
                                      productPrice: productPrice));
                                  widget.controller.addProducts(
                                      Products.getProducts[
                                          Products.getProducts.length - 1]);
                                  _databaseReference
                                      .child('Cart')
                                      .child(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .child('0')
                                      .remove();
                                },
                                child: Icon(
                                  Icons.add_circle,
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
            ),
          );
  }
}
