import 'package:flutter/material.dart';
import 'package:kwikshop/constants.dart';

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
