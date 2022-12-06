import 'package:flutter/material.dart';
import 'package:kwikshop/constants.dart';

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
