import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kwikshop/components/retailer_widget.dart';
import 'package:kwikshop/constants.dart';

import 'package:kwikshop/screens/offer&benefits_screen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  final Query _query = FirebaseDatabase.instance.ref().child("Stores");
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 15, bottom: 6),
              child: Image(
                image: AssetImage('images/label.png'),
                width: 190,
                height: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, bottom: 6),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hey! ',
                    style: kTextStyleSmallBold.copyWith(color: mainColor),
                  ),
                  const TextSpan(
                      text:
                          "It's time to shop your daily groceries from your\nnearby retailers",
                      style: kTextStyleSmall)
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, bottom: 6),
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
            padding: EdgeInsets.only(
              top: 10,
              left: 20,
            ),
            child: Text('Best Retailers Nearby', style: kTextStyleHeaders),
          ),
          SizedBox(
            height: 2250,
              child: FirebaseAnimatedList(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              query: _query,
              itemBuilder: (context, snapshot, animation, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: RetailerWidget(
                  index: index,
                  width: 380,
                ),
              ),
            ),
          )
        ],
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
