// ignore_for_file: deprecated_member_use

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikshop/constants.dart';

import 'package:kwikshop/screens/shop_screen.dart';

class RetailerWidget extends StatefulWidget {
  RetailerWidget({required this.index, this.width = 300});
  final int index;
  final double width;

  @override
  State<RetailerWidget> createState() => _RetailerWidgetState();
}

class _RetailerWidgetState extends State<RetailerWidget> {
  final List<String> getRetailUrl = [
    'images/store0.jpg',
    'images/store1.jpg',
    'images/store2.jpg',
    'images/store3.png',
    'images/store4.jpg',
    'images/store5.jpg',
    'images/store6.jpg',
    'images/store7.jpg',
    'images/store8.jpg',
    'images/store9.jpg',
  ];
  String? shopName;
  late String shopAddress;
  late double rating;
  late String type;

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  @override
  void initState() {
    _readDatabase(widget.index);
    super.initState();
  }

  _readDatabase(int index) {
    _databaseReference
        .child('Stores')
        .child(index.toString())
        .child('Name')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        shopName = databaseEvent.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Stores')
        .child(index.toString())
        .child('Address')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        shopAddress = databaseEvent.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Stores')
        .child(index.toString())
        .child('Rating')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        rating = databaseEvent.snapshot.value as double;
      });
    });
    _databaseReference
        .child('Stores')
        .child(index.toString())
        .child('Type')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        type = databaseEvent.snapshot.value.toString();
      });
    });
  }

  Color? color;
  void setRatingColor() {
    setState(() {
      if (rating >= 4.0) {
        color = const Color(0xff2FB47A);
      } else {
        color = const Color(0xffDB805E);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setRatingColor();
    return GestureDetector(
      onTap: () {
        Get.to(
            () =>
                ShopScreen(shopName: shopName, url: getRetailUrl[widget.index]),
            transition: Transition.cupertino);
      },
      child: Container(
        width: widget.width,
        height: 250,
        margin: const EdgeInsets.all(5),
        decoration: kContainerDecoration,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: widget.width,
                  height: 149,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        getRetailUrl[widget.index],
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 18, bottom: 10),
                  child: Text(shopName.toString(), style: kTextStyleLarge),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Row(
                    children: [
                      Icon(Icons.store_mall_directory_outlined,
                          color: mainColor),
                      Text(
                        type,
                        style: kTextStyleSmallBold.copyWith(color: Colors.grey),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 6, right: 3),
                        child: Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 7,
                        ),
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        color: mainColor,
                      ),
                      Text(shopAddress,
                          style:
                              kTextStyleSmallBold.copyWith(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: CircleAvatar(
                backgroundColor: color,
                child: Text(
                  rating.toString(),
                  style: kTextStyleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
