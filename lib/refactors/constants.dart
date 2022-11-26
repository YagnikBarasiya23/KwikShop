import 'package:flutter/material.dart';

const kTextStyleHeadings = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontSize: 35,
    fontFamily: 'Poppins');
const kTextStyleHeaders = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 25,
    fontFamily: 'Poppins');
const kTextStyleLarge = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    fontFamily: 'Poppins');
const kTextStyleSmall = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontFamily: 'Poppins');
const kTextStyleSmallBold = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    fontFamily: 'Poppins');
const kContainerDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(15)),
);
const kShadowColor = Colors.black;
const kTextFieldDecoration = InputDecoration(
  labelText: 'lableText',
  hintText: 'hintText',
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      borderSide: BorderSide(color: Colors.grey)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      borderSide: BorderSide(color: Colors.black)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      borderSide: BorderSide(color: Colors.red, width: 2.0)),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      borderSide: BorderSide(color: Colors.red, width: 2.0)),

  // Inp
);
