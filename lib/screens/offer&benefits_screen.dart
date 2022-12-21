import 'package:flutter/material.dart';
import 'package:kwikshop/components/retailer_widget.dart';
import 'package:kwikshop/constants.dart';

class OfferBenefitsScreen extends StatelessWidget {
  OfferBenefitsScreen({this.index = 0});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Offer&Benefits', style: kTextStyleHeaders),

            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor:  Colors.transparent,
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
        RetailerWidget(index: 0, width: 380),
        RetailerWidget(index: 1, width: 380),
        RetailerWidget(index: 2, width: 380),
        RetailerWidget(index: 3, width: 380),
        RetailerWidget(index: 4, width: 380),
        RetailerWidget(index: 5, width: 380),
        RetailerWidget(index: 7, width: 380),

      ],
    );
  } else if (index == 1) {
    return Column(
      children: [
        RetailerWidget(index: 4, width: 380),
        RetailerWidget(index: 6, width: 380),
      ],
    );
  } else if (index == 0) {
    return Column(
      children: [
        RetailerWidget(index: 8, width: 380),
        RetailerWidget(index: 1, width: 380),
        RetailerWidget(index: 7, width: 380),
        RetailerWidget(index: 3, width: 380),
      ],
    );
  }
  return Container();
}
