// ignore_for_file: deprecated_member_use

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikshop/refactors/constants.dart';
import 'package:kwikshop/screens/shop_screen.dart';

Widget button(String text, double width) {
  return Card(
    elevation: 5.5,
    margin: const EdgeInsets.all(5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      width: width,
      height: 40,
      decoration: kContainerDecoration.copyWith(
          color: Colors.amber.shade700,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          text,
          style: kTextStyleLarge.copyWith(color: Colors.black),
        ),
      ),
    ),
  );
}

class AddressContainer extends StatefulWidget {
  AddressContainer({required this.index});
  final int index;
  @override
  State<AddressContainer> createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  Icon? icon;
  double elevation = 0;
  Color colour = Colors.grey.shade100;
  int flag = 0;
  String homeName = '';
  String pinCode = '';
  String streetName = '';
  late final DatabaseReference _databaseReference;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  badgeFunction() {
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

  readDatabase(int index) {
    _databaseReference
        .child('Details')
        .child(currentUser.toString())
        .child(index.toString())
        .child('HomeName')
        .once()
        .then((value) {
      setState(() {
        homeName = value.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Details')
        .child(currentUser.toString())
        .child(index.toString())
        .child('StreetName')
        .once()
        .then((value) {
      setState(() {
        streetName = value.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Details')
        .child(currentUser.toString())
        .child(index.toString())
        .child('Pincode')
        .once()
        .then((value) {
      setState(() {
        pinCode = value.snapshot.value.toString();
      });
    });
  }

  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
    readDatabase(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      elevation: elevation,
      badgeColor: colour,
      badgeContent: icon,
      child: GestureDetector(
        onTap: () {
          setState(() {
            flag = 1;
          });
          badgeFunction();
        },
        child: Container(
          width: 380,
          decoration: kContainerDecoration.copyWith(boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 10,
                color: kShadowColor.withOpacity(0.23))
          ]),
          margin: const EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(homeName.toString(),
                    style: kTextStyleLarge.copyWith(color: Colors.black)),
                Text(streetName.toString(),
                    style: kTextStyleSmall.copyWith(color: Colors.black)),
                Text(pinCode.toString(),
                    style: kTextStyleSmall.copyWith(color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
   String shopName ='';
   String shopAddress='';
  String rating='';
   String distance='';

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
                    const Icon(CupertinoIcons.star_fill,
                        color: Color(0xFFFE9D34)),
                    Text(rating,
                        style: kTextStyleSmall.copyWith(color: Colors.white)),
                    const SizedBox(width: 10),
                    const Icon(
                      CupertinoIcons.stopwatch_fill,
                      color: Color(0xFFFF5621),
                    ),
                    Text(distance,
                        style: kTextStyleSmall.copyWith(color: Colors.white)),
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

Widget tile(String text, IconData icon) {
  return Card(
    elevation: 2.5,
    margin: const EdgeInsets.all(5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Container(
      decoration: kContainerDecoration,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Icon(icon, color: Colors.amber.shade800, size: 25),
        title: Text(text, style: kTextStyleSmallBold),
      ),
    ),
  );
}
