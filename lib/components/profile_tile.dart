import 'package:flutter/material.dart';
import 'package:kwikshop/constants.dart';

Widget tile(String text, IconData icon) {
  return Container(
    margin: const EdgeInsets.all(5),
    decoration: kContainerDecoration,
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: Icon(icon, color: mainColor, size: 30),
      title: Text(text, style: kTextStyleSmallBold),
    ),
  );
}
