import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.customClipper});
  final CustomClipper<Path> customClipper;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        ClipPath(
          clipper: customClipper,
          child: Container(
            height: 364,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.secondaryContainer,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BigClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = size.height / 500;
    path.lineTo(
        -0.003999999999997783 * xScaling, 341.78499999999997 * yScaling);
    path.cubicTo(
      -0.003999999999997783 * xScaling,
      341.78499999999997 * yScaling,
      23.461000000000002 * xScaling,
      363.15099999999995 * yScaling,
      71.553 * xScaling,
      363.15099999999995 * yScaling,
    );
    path.cubicTo(
      119.645 * xScaling,
      363.15099999999995 * yScaling,
      142.21699999999998 * xScaling,
      300.186 * yScaling,
      203.29500000000002 * xScaling,
      307.21 * yScaling,
    );
    path.cubicTo(
      264.373 * xScaling,
      314.234 * yScaling,
      282.666 * xScaling,
      333.47299999999996 * yScaling,
      338.408 * xScaling,
      333.47299999999996 * yScaling,
    );
    path.cubicTo(
      394.15000000000003 * xScaling,
      333.47299999999996 * yScaling,
      413.99600000000004 * xScaling,
      254.199 * yScaling,
      413.99600000000004 * xScaling,
      254.199 * yScaling,
    );
    path.cubicTo(
      413.99600000000004 * xScaling,
      254.199 * yScaling,
      413.99600000000004 * xScaling,
      0 * yScaling,
      413.99600000000004 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      413.99600000000004 * xScaling,
      0 * yScaling,
      -0.003999999999976467 * xScaling,
      0 * yScaling,
      -0.003999999999976467 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      -0.003999999999976467 * xScaling,
      0 * yScaling,
      -0.003999999999997783 * xScaling,
      341.78499999999997 * yScaling,
      -0.003999999999997783 * xScaling,
      341.78499999999997 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class SmallClipper extends CustomClipper<Path> {
  @override
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = size.height / 896;
    path.lineTo(-0.003999999999997783 * xScaling, 217.841 * yScaling);
    path.cubicTo(
      -0.003999999999997783 * xScaling,
      217.841 * yScaling,
      19.14 * xScaling,
      265.91999999999996 * yScaling,
      67.233 * xScaling,
      265.91999999999996 * yScaling,
    );
    path.cubicTo(
      115.326 * xScaling,
      265.91999999999996 * yScaling,
      112.752 * xScaling,
      234.611 * yScaling,
      173.83299999999997 * xScaling,
      241.635 * yScaling,
    );
    path.cubicTo(
      234.914 * xScaling,
      248.659 * yScaling,
      272.866 * xScaling,
      301.691 * yScaling,
      328.608 * xScaling,
      301.691 * yScaling,
    );
    path.cubicTo(
      384.34999999999997 * xScaling,
      301.691 * yScaling,
      413.99600000000004 * xScaling,
      201.977 * yScaling,
      413.99600000000004 * xScaling,
      201.977 * yScaling,
    );
    path.cubicTo(
      413.99600000000004 * xScaling,
      201.977 * yScaling,
      413.99600000000004 * xScaling,
      0 * yScaling,
      413.99600000000004 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      413.99600000000004 * xScaling,
      0 * yScaling,
      -0.003999999999976467 * xScaling,
      0 * yScaling,
      -0.003999999999976467 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      -0.003999999999976467 * xScaling,
      0 * yScaling,
      -0.003999999999997783 * xScaling,
      217.841 * yScaling,
      -0.003999999999997783 * xScaling,
      217.841 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
