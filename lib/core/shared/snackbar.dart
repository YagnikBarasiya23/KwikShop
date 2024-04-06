import 'package:flutter/material.dart';

SnackBar appSnackBar(String text, {bool isError = true}) => SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 2500),
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? Colors.red : Colors.black,
    );
