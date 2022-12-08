import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kwikshop/constants.dart';
import 'package:kwikshop/screens/shop_screen.dart';

class RetailerWidget extends StatefulWidget {
  RetailerWidget({required this.index, this.height = 0, this.width = 300});
  final int index;
  final double height;
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
  String shopName = '';
  String shopAddress = '';
  String rating = '';
  String distance = '';

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
        .child(index.toString())
        .child('name')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        shopName = databaseEvent.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Stores')
        .child(index.toString())
        .child('address')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        shopAddress = databaseEvent.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Stores')
        .child(index.toString())
        .child('rating')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        rating = databaseEvent.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Stores')
        .child(index.toString())
        .child('delivery_time')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        distance = databaseEvent.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            () =>
                ShopScreen(shopName: shopName, url: getRetailUrl[widget.index]),
            transition: Transition.cupertino);
      },
      child: Card(
        elevation: 2.5,
        margin: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: kContainerDecoration.copyWith(
            image: DecorationImage(
                image: AssetImage(getRetailUrl[widget.index]),
                fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shopName,
                    style: kTextStyleLarge.copyWith(color: Colors.white)),
                Text(shopAddress,
                    style: kTextStyleSmall.copyWith(color: Colors.white)),
                const Divider(thickness: 0.8, height: 20, color: Colors.white),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.solidStar, color: ratingColor),
                    const SizedBox(width: 5),
                    Text(rating,
                        style:
                            kTextStyleSmallBold.copyWith(color: Colors.white)),
                    const SizedBox(width: 10),
                    const Icon(
                      FontAwesomeIcons.stopwatch,
                      color: Color(0xFFFF5621),
                    ),
                    const SizedBox(width: 5),
                    Text(distance,
                        style:
                            kTextStyleSmallBold.copyWith(color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
