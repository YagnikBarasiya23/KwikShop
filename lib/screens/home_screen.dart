import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwikshop/components/retailer_widget.dart';
import 'package:kwikshop/constants.dart';

import 'package:kwikshop/screens/offer&benefits_screen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Position _position;

  int activeIndex = 0;
  double latitude = 0;
  double longitude = 0;
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
    });
    latitude = position.latitude;
    longitude = position.longitude;
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
    };
    _databaseReference
        .child(currentUser.toString())
        .child('Location')
        .set(details);
  }

  late DatabaseReference _databaseReference;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('Details');
    getCurrentLocation();
    addMarker();
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 6),
              child: Image(
                image: AssetImage('images/label.png'),
                width: 190,
                height: 50,
              ),
            ),
            Card(
              elevation: 1.5,
              child: SizedBox(
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
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 10, right: 4, bottom: 6),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Hey! ',
                  style: kTextStyleSmallBold.copyWith(color: mainColor),
                ),
                const TextSpan(
                    text:
                        "It's time to shop your daily groceries from your nearby retailers",
                    style: kTextStyleSmall)
              ])),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 6),
              child: Text('Offer & Benefits', style: kTextStyleHeaders),
            ),
            CarouselSlider.builder(
                itemCount: 3,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                      onTap: () {
                        Get.to(() => OfferBenefitsScreen(index: index),
                            transition: Transition.cupertino);
                      },
                      child: bannerWidget(index));
                },
                options: CarouselOptions(
                  height: 120,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                )),
            const SizedBox(height: 5),
            Center(
              child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  duration: const Duration(milliseconds: 250),
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: mainColor,
                    dotHeight: 5,
                    dotWidth: 5,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 6),
              child: Text('Best Retailers Nearby', style: kTextStyleHeaders),
            ),
            SizedBox(
              height: 2300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RetailerWidget(
                      index: index,
                      height: 200,
                      width: 380,
                    ),
                  );
                },
                itemCount: 10,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget bannerWidget(int index) {
  return Card(
    elevation: 2.5,
    margin: const EdgeInsets.all(5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Container(
      width: 300,
      decoration: kContainerDecoration.copyWith(
        image: DecorationImage(
            image: AssetImage('images/banner$index.jpg'), fit: BoxFit.fill),
      ),
    ),
  );
}
