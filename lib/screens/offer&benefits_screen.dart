import 'package:flutter/material.dart';
import 'package:kwikshop/refactors/constants.dart';
import 'package:kwikshop/refactors/widgets.dart';

class OfferBenefitsScreen extends StatelessWidget {
  OfferBenefitsScreen({this.index = 0});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Offer&Benefits', style: kTextStyleHeaders),
            elevation: 0.5,
            iconTheme: const IconThemeData(color: Colors.black),
            flexibleSpace: Container(
              color: Colors.grey.shade100,
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getStores(index),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

Widget getStores(int index) {
  if (index == 2) {
    return Column(
      children: [
        RetailerWidget(index: 0, height: 200, width: 380),
        RetailerWidget(index: 1, height: 200, width: 380),
        RetailerWidget(index: 2, height: 200, width: 380),
        RetailerWidget(index: 3, height: 200, width: 380),
        RetailerWidget(index: 4, height: 200, width: 380),
        RetailerWidget(index: 5, height: 200, width: 380),
        RetailerWidget(index: 7, height: 200, width: 380),
        RetailerWidget(index: 8, height: 200, width: 380),
        RetailerWidget(index: 9, height: 200, width: 380),
      ],
    );
  } else if (index == 1) {
    return Column(
      children: [
        RetailerWidget(index: 0, height: 200, width: 380),
        RetailerWidget(index: 1, height: 200, width: 380),
      ],
    );
  } else if (index == 0) {
    return Column(
      children: [
        RetailerWidget(index: 0, height: 200, width: 380),
        RetailerWidget(index: 1, height: 200, width: 380),
        RetailerWidget(index: 2, height: 200, width: 380),
        RetailerWidget(index: 3, height: 200, width: 380),
      ],
    );
  }
  return Container();
}
