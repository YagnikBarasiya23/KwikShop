import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwikshop/features/welcome/presentation/screens/welcome_screen.dart';
import '../../../../core/shared/app_button.dart';
import '../../../../core/shared/app_dailog.dart';
import '../../../../core/shared/app_loading.dart';
import '../../../../injection_container.dart';
import '../../../cart/presentation/bloc/cart_cubit.dart';
import '../../../profile/presentation/widgets/profile_tile.dart';
import '../../domain/usecase/checkout_usecase.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.storeName});
  static const String routeName = '/checkout';
  final String storeName;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Position position;

  double latitude = 0;

  double longitude = 0;

  List<Placemark>? placeMark;

  final Completer<GoogleMapController> _completer = Completer();

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Give permission');
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  void getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      this.position = position;
      latitude = position.latitude;
      longitude = position.longitude;
    });
    placeMark = await placemarkFromCoordinates(latitude, longitude);
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('2'),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(latitude, longitude),
        ),
      );
    });
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 19,
      tilt: 37,
    );
    final GoogleMapController googleMapController = await _completer.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
    checkoutInjection.get<CheckoutLocationDetailsUseCase>().call(
          params: LocationDetails(
              placeMark: placeMark!, latitude: latitude, longitude: longitude),
        );
  }

  final Set<Marker> _markers = {};

  void addMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('1'),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(latitude, longitude),
        ),
      );
    });
  }

  final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 19,
    tilt: 37,
  );

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    addMarker();
  }

  final Stream<DocumentSnapshot<Map<String, dynamic>>> _stream =
      FirebaseFirestore.instance
          .collection('ProfileDetails')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('UserDetails')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading();
          } else {
            final String firstName = snapshot.data!['FirstName'];
            final String lastName = snapshot.data!['LastName'];
            final String mobileNumber = snapshot.data!['MobileNumber'];
            return placeMark == null
                ? const AppLoading()
                : SingleChildScrollView(
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
                                  markers: _markers,
                                  zoomGesturesEnabled: true,
                                  zoomControlsEnabled: false,
                                  initialCameraPosition: _cameraPosition,
                                  onMapCreated: (controller) {
                                    _completer.complete(controller);
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
                              title: "${placeMark!.first.name}, "
                                  "${placeMark!.first.street}, "
                                  "${placeMark!.first.administrativeArea}, "
                                  "${placeMark!.first.locality}, "
                                  "${placeMark!.first.postalCode}",
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
                                  storeName: widget.storeName,
                                  animation: animation,
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
      ),
    );
  }
}

class OnSuccess extends StatelessWidget {
  const OnSuccess(
      {super.key, required this.storeName, required this.animation});
  final String storeName;
  final Animation<double> animation;

  void success(BuildContext context) {
    final grandTotal = context.read<CartCubit>().grandTotal;

    checkoutInjection.get<CheckoutOrderDetailsUseCase>().call(
          params: OrderDetails(
            orderId: orderId.get<String>(),
            storeName: storeName,
            grandTotal: grandTotal,
          ),
        );
    context.read<CartCubit>().clear();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
    context.read<CartCubit>().clear();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      onPressed: () => success(context),
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
