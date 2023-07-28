import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: 55,
      width: screenWidth,
      child: const Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            prefixIcon: Icon(Icons.search, size: 25, color: Colors.black),
            focusedBorder: InputBorder.none,
          ),
          textAlignVertical: TextAlignVertical.top,
          textCapitalization: TextCapitalization.sentences,
          cursorColor: Colors.black,
          cursorRadius: Radius.circular(5),
          cursorHeight: 20,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
