import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OffersWidget extends StatefulWidget {
  const OffersWidget({super.key});

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  late final PageController _pageController =
      PageController(viewportFraction: 0.9);
  static const List<String> urls = [
    'https://www.guestblogging.pro/wp-content/uploads/2022/10/Best-Online-Grocery-Store-in-India.jpg',
    'https://www.crushpixel.com/big-static23/preview4/vector-online-grocery-store-banner-6054271.jpg',
    'https://www.grocistore.com/admin/uploads/banners/web_banners/banner1576516931.JPG',
  ];

  Timer? _timer;

  int _currentIndex = 0;

  final double _itemWidth = 300;

  final int _numberOfItems = urls.length;

  @override
  void initState() {
    _startAutoplay();
    super.initState();
  }

  @override
  void dispose() {
    _stopAutoplay();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoplay() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        if (_currentIndex < _numberOfItems - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
        _scrollToIndex(_currentIndex);
      },
    );
  }

  void _stopAutoplay() {
    _timer?.cancel();
  }

  void _scrollToIndex(int index) {
    _pageController.animateTo(
      index * _itemWidth,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: screenWidth,
      height: 150,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: CachedNetworkImage(
              imageUrl: urls[index],
              fit: BoxFit.fill,
            ),
          ),
        ),
        itemCount: urls.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
