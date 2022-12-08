import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/body_widgets/header_widget.dart';

import 'package:get/get.dart';
import 'package:kwikshop/components/address_container.dart';
import 'package:kwikshop/constants.dart';

import 'package:kwikshop/screens/add_detail_screen.dart';

class AddressScreen extends StatelessWidget {
  int flag = 0;
  int length = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => DetailsScreen(flag: flag = 1),
                        transition: Transition.cupertino);
                  },
                  icon: Icon(
                    CupertinoIcons.pencil,
                    color: Colors.amber.shade700,
                    size: 23,
                  )),
            ],
            title: const Text('Addresses', style: kTextStyleHeaders),
            elevation: 0.5,
            iconTheme: const IconThemeData(color: Colors.black),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ])),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                      height: 80,
                      child: HeaderWidget(
                        showIcon: false,
                        height: 80,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Column(
                          children: [
                            SizedBox(
                              height: 165,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return AddressContainer(index: index);
                                },
                                itemCount: 1,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
