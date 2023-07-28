import 'package:flutter/material.dart';

SnackBar appSnackBar(String text) => SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 1500),
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );
