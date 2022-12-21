import 'package:flutter/material.dart';
import 'package:kwikshop/constants.dart';

Widget button(String text, double width, Function() onPressed) {
  return MaterialButton(
    elevation: 3,
    height: 50,
    minWidth: 300,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: mainColor,
    onPressed: onPressed,
    child: Text(text, style: kTextStyleLarge),
  );
}
