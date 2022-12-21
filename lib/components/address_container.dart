// ignore_for_file: deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/constants.dart';

class AddressContainer extends StatefulWidget {
  @override
  State<AddressContainer> createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  String? name;
  late String postalCode;
  late String street;
  late String city;
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  readDatabase() {
    _databaseReference
        .child('Details')
        .child(currentUser.toString())
        .child('Location')
        .child('Name')
        .once()
        .then((value) {
      setState(() {
        name = value.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Details')
        .child(currentUser.toString())
        .child('Location')
        .child('Street')
        .once()
        .then((value) {
      setState(() {
        street = value.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Details')
        .child(currentUser.toString())
        .child('Location')
        .child('PostalCode')
        .once()
        .then((value) {
      setState(() {
        postalCode = value.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Details')
        .child(currentUser.toString())
        .child('Location')
        .child('City')
        .once()
        .then((value) {
      setState(() {
        city = value.snapshot.value.toString();
      });
    });
  }

  @override
  void initState() {
    readDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return name == null
        ? const Center(
            child: CircularProgressIndicator(
              color: greenColor,
            ),
          )
        : Container(
            width: 380,
            decoration: kContainerDecoration,
            margin: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name.toString(), style: kTextStyleLarge),
                  Text(street.toString(), style: kTextStyleSmall),
                  Text(city.toString(), style: kTextStyleSmall),
                  Text(postalCode.toString(), style: kTextStyleSmall),
                ],
              ),
            ),
          );
  }
}
