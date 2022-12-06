import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/constants.dart';

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
