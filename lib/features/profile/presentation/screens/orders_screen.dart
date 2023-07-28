import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kwikshop/core/shared/app_loading.dart';
import 'package:kwikshop/features/cart/presentation/bloc/orderid_cubit.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  static final _stream = FirebaseFirestore.instance
      .collection('Orders')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Order')
      .snapshots();
  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading();
          } else {
            return snapshot.data!.docs.isEmpty
                ? const Center(
                    child: Text('Nothing to Show'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(18),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> orders =
                            snapshot.data!.docs[index].data();
                        return OrderCard(
                          grandTotal: orders['TotalPrice'],
                          date: orders['Date'],
                          storeName: orders['ShopName'],
                          time: orders['Time'],
                          index: index,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                    ),
                  );
          }
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.grandTotal,
    required this.date,
    required this.index,
    required this.storeName,
    required this.time,
  });

  final double grandTotal;
  final String date;
  final int index;
  final String storeName;
  final String time;

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter =
        NumberFormat.simpleCurrency(decimalDigits: 0, locale: "en_IN");
    return Card(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
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
                      Text(
                        storeName,
                      ),
                      Text(
                        formatter.format(grandTotal),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        date,
                      ),
                      Text(
                        time,
                      )
                    ],
                  )
                ],
              ),
              const Divider(thickness: 0.5),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Orders')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Order')
                    .doc(context.watch<OrderIdCubit>().state[index])
                    .collection('Items')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const AppLoading();
                  } else {
                    return SizedBox(
                      width: 350,
                      height: 50,
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> items =
                              snapshot.data!.docs[index].data();
                          return Row(
                            children: [
                              Text(
                                items['Product'],
                              ),
                              Text(
                                "(${items['Quantity']}) ",
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
