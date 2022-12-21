import 'package:flutter/material.dart';
import 'package:kwikshop/components/retailer_widget.dart';
import 'package:kwikshop/constants.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({this.name});
  final String? name;
  late final int length;
  late final int flag;
  setIndex() {
    if (name == 'Fruits') {
      length = 5;
      flag = 1;
    } else if (name == 'Vegetables') {
      length = 5;
      flag = 2;
    } else if (name == 'Snacks') {
      length = 6;
      flag = 3;
    } else if (name == 'Meats') {
      length = 1;
      flag = 4;
    } else if (name == 'Bakery') {
      length = 6;
      flag = 5;
    } else if (name == 'Cleaners') {
      length = 5;
      flag = 6;
    } else if (name == 'Frozen Foods') {
      length = 6;
      flag = 7;
    } else if (name == 'Personal Care') {
      length = 5;
      flag = 8;
    } else if (name == 'Beverages') {
      length = 6;
      flag = 9;
    } else if (name == 'Dairy') {
      length = 7;
      flag = 10;
    } else if (name == 'Canned Goods') {
      length = 7;
      flag = 11;
    } else if (name == 'Food Grains') {
      length = 5;
      flag = 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    setIndex();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(name.toString(), style: kTextStyleHeaders),
            elevation: 0.5,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getStores(length, flag),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

Widget getStores(int length, int flag) {
  if (length == 5 && flag == 1) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 1, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 8, width: 380),
      ],
    );
  } else if (length == 5 && flag == 2) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 1, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 8, width: 380),
      ],
    );
  } else if (length == 6 && flag == 3) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 1, width: 380),
        RetailerWidget(index: 4, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 8, width: 380),
      ],
    );
  } else if (length == 1 && flag == 4) {
    return Column(
      children: [
        RetailerWidget(index: 4, width: 380),
      ],
    );
  } else if (length == 6 && flag == 5) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 1, width: 380),
        RetailerWidget(index: 4, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 8, width: 380),
      ],
    );
  } else if (length == 5 && flag == 6) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 2, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 8, width: 380),
      ],
    );
  } else if (length == 6 && flag == 7) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 2, width: 380),
        RetailerWidget(index: 4, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 8, width: 380),
      ],
    );
  } else if (length == 5 && flag == 8) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 2, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 8, width: 380),
      ],
    );
  } else if (length == 6 && flag == 9) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 4, width: 380),
        RetailerWidget(index: 2, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 8, width: 380),
      ],
    );
  } else if (length == 7 && flag == 10) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 2, width: 380),
        RetailerWidget(index: 3, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 8, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 4, width: 380),
      ],
    );
  } else if (length == 7 && flag == 11) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 4, width: 380),
        RetailerWidget(index: 3, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 8, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 2, width: 380),
      ],
    );
  } else if (length == 5 && flag == 12) {
    return Column(
      children: [
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 2, width: 380),
        RetailerWidget(index: 6, width: 380),
        RetailerWidget(index: 8, width: 380),
        RetailerWidget(index: 7, width: 380),
      ],
    );
  }
  return Container();
}
