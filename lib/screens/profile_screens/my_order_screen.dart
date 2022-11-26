// ignore_for_file: deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/body_widgets/header_widget.dart';
import 'package:kwikshop/refactors/constants.dart';
import 'package:kwikshop/screens/cart_screen.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('My Orders', style: kTextStyleHeaders),
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
            child: flag != 0
                ? Column(
                    children: [
                      const SizedBox(height: 200),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: const Image(
                          image: AssetImage('images/emptycart.png'),
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 80,
                          child: HeaderWidget(
                            showIcon: false,
                            height: 80,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(26.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 100),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 195,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return OrderContainer(index: index);
                                      },
                                      itemCount: 1,
                                      scrollDirection: Axis.vertical,
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

class OrderContainer extends StatefulWidget {
  OrderContainer({required this.index});
  final int index;

  @override
  State<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  String grandTotal = '';
  String date = '';
  String shopName = '';
  final currentId = FirebaseAuth.instance.currentUser!.uid;
  late DatabaseReference _databaseReference;
  late final Query _query = FirebaseDatabase.instance
      .ref()
      .child('Cart')
      .child(currentId)
      .child('0')
      .child('Items');

  void readDB(int index) {
    _databaseReference
        .child('Cart')
        .child(currentId)
        .child(index.toString())
        .child('ShopName')
        .child('ShopName')
        .once()
        .then((databaseEvent) {
      setState(() {
        shopName = databaseEvent.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Cart')
        .child(currentId)
        .child(index.toString())
        .child('TotalPrice')
        .once()
        .then((databaseEvent) {
      setState(() {
        grandTotal = databaseEvent.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Cart')
        .child(currentId)
        .child(index.toString())
        .child('Date')
        .once()
        .then((databaseEvent) {
      setState(() {
        date = databaseEvent.snapshot.value.toString();
      });
    });
  }

  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
    readDB(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 140,
      decoration: kContainerDecoration.copyWith(boxShadow: [
        BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 10,
            color: kShadowColor.withOpacity(0.23))
      ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shopName.toString(), style: kTextStyleSmallBold),
                    Text("${grandTotal.toString()}rs", style: kTextStyleSmall),
                  ],
                ),
                Text(date.toString(),
                    style:
                        kTextStyleSmall.copyWith(fontWeight: FontWeight.w600))
              ],
            ),
            const Divider(thickness: 0.5),
            SizedBox(
              width: 350,
              height: 50,
              child: FirebaseAnimatedList(
                query: _query,
                itemBuilder: (context, snapshot, animation, index) {
                  Map orderList = snapshot.value as Map;

                  return Row(
                    children: [
                      Text(
                        orderList['Product'].toString(),
                        style: kTextStyleSmall,
                      ),
                      Text("(${orderList['Quantity'].toString()})",
                          style: kTextStyleSmall),
                    ],
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
