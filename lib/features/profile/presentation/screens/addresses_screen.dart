import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/core/shared/app_loading.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  static final _stream = FirebaseFirestore.instance
      .collection('ProfileDetails')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Location')
      .snapshots();
  static const String routeName = '/addresses';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addresses'),
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
                        final Map<String, dynamic> address =
                            snapshot.data!.docs[index].data();
                        return AddressCard(
                          name: address['Name'],
                          postalCode: address['PostalCode'],
                          street: address['Street'],
                          city: address['City'],
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

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.name,
    required this.postalCode,
    required this.street,
    required this.city,
  });

  final String name;
  final String postalCode;
  final String street;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
              ),
              Text(
                street,
              ),
              Text(
                city,
              ),
              Text(
                postalCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
