import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwikshop/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:kwikshop/features/welcome/presentation/screens/welcome_screen.dart';

import '../../../../core/shared/app_button.dart';
import '../../../../core/shared/app_dailog.dart';
import '../../../../core/shared/app_loading.dart';
import '../../../../injection_container.dart';
import '../../../profile/presentation/widgets/profile_tile.dart';
import '../../domain/usecase/checkout_usecase.dart';
import '../bloc/checkout_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen(
      {super.key, required this.storeName, required this.grandTotal});

  static const String routeName = '/checkout';
  final String storeName;
  final double grandTotal;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold);
    context.read<CheckoutBloc>().add(const CurrentLocationEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutInitial) {
            return const AppLoading();
          } else if (state is CheckoutLoad) {
            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('ProfileDetails')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('UserDetails')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const AppLoading();
                } else {
                  final String firstName = snapshot.data!['FirstName'];
                  final String lastName = snapshot.data!['LastName'];
                  final String mobileNumber = snapshot.data!['MobileNumber'];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 18, right: 18, bottom: 18, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 380,
                                height: 130,
                                child: GoogleMap(
                                  markers: state.mapModel.markers,
                                  zoomGesturesEnabled: true,
                                  zoomControlsEnabled: false,
                                  initialCameraPosition:
                                      state.mapModel.cameraPosition,
                                  onMapCreated: (controller) {
                                    state.mapModel.completer
                                        .complete(controller);
                                  },
                                ),
                              ),
                              Container(
                                width: 380,
                                height: 130,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 5),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, bottom: 6),
                            child: Text(
                              'Delivery Address',
                              style: titleStyle,
                            ),
                          ),
                          Card(
                            child: ProfileTile(
                              title: "${state.mapModel.placeMark.first.name}, "
                                  "${state.mapModel.placeMark.first.street}, "
                                  "${state.mapModel.placeMark.first.administrativeArea}, "
                                  "${state.mapModel.placeMark.first.locality}, "
                                  "${state.mapModel.placeMark.first.postalCode}",
                              icon: Icons.location_on,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, bottom: 6),
                            child: Text(
                              'Contact Name',
                              style: titleStyle,
                            ),
                          ),
                          Card(
                            child: ProfileTile(
                              title: "$firstName $lastName",
                              icon: Icons.person,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, bottom: 6),
                            child: Text(
                              'Your Number',
                              style: titleStyle,
                            ),
                          ),
                          Card(
                            child: ProfileTile(
                              title: mobileNumber,
                              icon: Icons.phone,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, bottom: 6),
                            child: Text(
                              'Payment Method',
                              style: titleStyle,
                            ),
                          ),
                          const Card(
                            child: ProfileTile(
                                title: "Cash on Delivery",
                                icon: Icons.currency_rupee),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: AppButton(
                              onPressed: () => showGeneralDialog(
                                transitionDuration:
                                    const Duration(milliseconds: 400),
                                context: context,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const SizedBox(),
                                transitionBuilder: (context, animation,
                                        secondaryAnimation, child) =>
                                    OnSuccess(
                                  storeName: storeName,
                                  animation: animation,
                                  grandTotal: grandTotal,
                                ),
                              ),
                              title: 'Place Order',
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return const Text("ERROR");
          }
        },
      ),
    );
  }
}

class OnSuccess extends StatelessWidget {
  const OnSuccess({
    super.key,
    required this.storeName,
    required this.animation,
    required this.grandTotal,
  });

  final String storeName;
  final Animation<double> animation;
  final double grandTotal;

  void success(BuildContext context, double grandTotal) {
    checkoutInjection.get<CheckoutOrderDetailsUseCase>().call(
          params: OrderDetails(
            orderId: orderId.get<String>(),
            storeName: storeName,
            grandTotal: grandTotal,
          ),
        );
    context.read<CartBloc>().add(const CartClear());
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
    context.read<CartBloc>().add(const CartClear());
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      onPressed: () => success(context, grandTotal),
      image: const Icon(
        Icons.check_circle,
        size: 100,
        color: Colors.green,
      ),
      title: "Order Successful",
      desc: "Thank you so much for your order",
      animation: animation,
    );
  }
}
