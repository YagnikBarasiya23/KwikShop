import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.imageUrl,
    this.height = 30,
    this.isIcon = false,
    this.width = 30,
    this.color,
    this.fit = BoxFit.fill,
  }) : super(key: key);
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final bool isIcon;
  final Color? color;
  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 365),
      maxNrOfCacheObjects: 1000,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      color: color,
      cacheManager: customCacheManager,
      width: width,
      height: height,
      imageUrl: imageUrl,
      fit: fit,
      progressIndicatorBuilder: (context, url, progress) =>
          ProgressWidget(progress: progress.progress, isIcon: isIcon),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.red,
        size: 25,
      ),
    );
  }
}

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    super.key,
    required this.progress,
    required this.isIcon,
  });
  final double? progress;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return progress == null
        ? CustomShimmer(isIcon: isIcon)
        : Stack(
            fit: StackFit.loose,
            children: [
              Center(
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(
                    value: progress,
                    valueColor: const AlwaysStoppedAnimation(Colors.green),
                    backgroundColor: Colors.blueGrey,
                    strokeWidth: 4,
                  ),
                ),
              ),
              Center(
                child: progress == 1
                    ? const Icon(
                        Icons.done_rounded,
                        color: Colors.green,
                        size: 30,
                      )
                    : Text(
                        (progress! * 100).toStringAsFixed(0),
                      ),
              )
            ],
          );
  }
}

class CustomShimmer extends StatefulWidget {
  const CustomShimmer({super.key, required this.isIcon});
  final bool isIcon;

  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _animationStart;
  late Animation<Alignment> _animationEnd;
  @override
  void initState() {
    setAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void setAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationStart = TweenSequence<Alignment>(
      [
        TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
      ],
    ).animate(_animationController);
    _animationEnd = TweenSequence<Alignment>(
      [
        TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
      ],
    ).animate(_animationController);
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) => Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade300,
              Colors.white,
            ],
            begin: _animationStart.value,
            end: _animationEnd.value,
          ),
          borderRadius: widget.isIcon
              ? BorderRadius.circular(100)
              : BorderRadius.circular(15),
        ),
      ),
    );
  }
}
