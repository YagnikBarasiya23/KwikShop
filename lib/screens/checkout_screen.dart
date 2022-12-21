// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kwikshop/body_widgets/navigation_bar.dart';
import 'package:kwikshop/components/our_button.dart';
import 'package:kwikshop/components/profile_tile.dart';
import 'package:kwikshop/constants.dart';
import 'package:kwikshop/models/cart_controller.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('Cart');

  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  final CartController _cartController = Get.find();

  late Position _position;

  double latitude = 0;

  double longitude = 0;
  List<Placemark>? placeMark;
  final Completer<GoogleMapController> _controller = Completer();

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
      _position = position;
      latitude = position.latitude;
      longitude = position.longitude;
    });
    placeMark = await placemarkFromCoordinates(latitude, longitude);
    setState(() {
      _markers.add(Marker(
          markerId: const MarkerId('2'),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(latitude, longitude)));
    });
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 19,
      tilt: 37,
    );
    final GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});

    Map<String, String> details = {
      'Latitude': latitude.toString(),
      'Longitude': longitude.toString(),
      'Name': placeMark![0].name.toString(),
      'Street': placeMark![0].street.toString(),
      'City': placeMark![0].locality.toString(),
      'PostalCode': placeMark![0].postalCode.toString(),
    };
    _databaseReferenceLocation
        .child(currentUserId.toString())
        .child('Location')
        .set(details);
  }

  final DatabaseReference _databaseReferenceDetails =
      FirebaseDatabase.instance.reference();
  final DatabaseReference _databaseReferenceLocation =
      FirebaseDatabase.instance.ref().child("Details");
  late String firstName;
  late String lastName;
  late String number;
  readDatabase() {
    _databaseReferenceDetails
        .child('Details')
        .child(currentUserId.toString())
        .child(0.toString())
        .child('FirstName')
        .once()
        .then((value) {
      setState(() {
        firstName = value.snapshot.value.toString();
      });
    });
    _databaseReferenceDetails
        .child('Details')
        .child(currentUserId.toString())
        .child(0.toString())
        .child('LastName')
        .once()
        .then((value) {
      setState(() {
        lastName = value.snapshot.value.toString();
      });
    });
    _databaseReferenceDetails
        .child('Details')
        .child(currentUserId.toString())
        .child(0.toString())
        .child('Number')
        .once()
        .then((value) {
      setState(() {
        number = value.snapshot.value.toString();
      });
    });
  }

  final Set<Marker> _markers = {};

  void addMarker() {
    setState(() {
      _markers.add(Marker(
          markerId: const MarkerId('1'),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(latitude, longitude)));
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
    readDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: latitude == 0
          ? const Center(
              child: CircularProgressIndicator(
                color: greenColor,
              ),
            )
          : CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                  const SliverAppBar(
                    title: Text('Checkout', style: kTextStyleHeaders),
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Colors.transparent,
                  ),
                  SliverToBoxAdapter(
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
                                    _controller.complete(controller);
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
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, bottom: 6),
                            child: Text('Delivery Address',
                                style: kTextStyleLarge),
                          ),
                          tile(
                              "${placeMark![0].name}"
                              " , "
                              "${placeMark![0].street}"
                              " , "
                              "${placeMark![0].administrativeArea}"
                              " , "
                              "${placeMark![0].locality}"
                              " , "
                              "${placeMark![0].postalCode}",
                              Icons.location_on),
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, bottom: 6),
                            child: Text('Contact Name', style: kTextStyleLarge),
                          ),
                          tile("$firstName $lastName", Icons.person),
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, bottom: 6),
                            child: Text('Your Number', style: kTextStyleLarge),
                          ),
                          tile(number, Icons.phone),
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, bottom: 6),
                            child:
                                Text('Payment Method', style: kTextStyleLarge),
                          ),
                          tile("Cash on Delivery", Icons.attach_money),
                          const SizedBox(height: 20),
                          Center(
                            child: button("Place Order", 330, () {
                              {
                                Alert(
                                    context: context,
                                    buttons: [
                                      DialogButton(
                                        onPressed: () async {
                                          Get.offAll(() => NaviBar(),
                                              transition: Transition.cupertino);
                                          _cartController.product.clear();
                                        },
                                        color: mainColor,
                                        radius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: const Text('Back to Home'),
                                      ),
                                    ],
                                    image: const Image(
                                      image: AssetImage('images/success.png'),
                                      width: 300,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                    title: 'Order Successful',
                                    desc: 'Thank you so much for your order',
                                    style: const AlertStyle(
                                      animationType: AnimationType.shrink,
                                      titleStyle: kTextStyleLarge,
                                    ),
                                    closeFunction: () {
                                      Get.back();
                                    }).show();

                                _databaseReference
                                    .child(currentUserId)
                                    .child('0')
                                    .child('TotalPrice')
                                    .set(_cartController.Total);
                                _databaseReference
                                    .child(currentUserId)
                                    .child('0')
                                    .child('Date')
                                    .set(DateFormat('dd-MM-yyyy')
                                        .format(DateTime.now()));
                                _databaseReference
                                    .child(currentUserId)
                                    .child('0')
                                    .child('Time')
                                    .set(DateFormat('KK:mm a')
                                        .format(DateTime.now()));
                              }
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
    );
  }
}
