import 'package:flutter/material.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: size.height * .65,
            left: size.width * .21,
            child: CustomPaint(
              painter: Bubble(
                radius: 50,
                color1: colorScheme.primaryContainer,
                color2: colorScheme.secondaryContainer,
              ),
            ),
          ),
          Positioned(
            top: size.height * .98,
            left: size.width * .1,
            child: CustomPaint(
              painter: Bubble(
                radius: 170 - 30,
                color1: colorScheme.primaryContainer,
                color2: colorScheme.secondaryContainer,
              ),
            ),
          ),
          Positioned(
            top: size.height * .5,
            left: size.width * .12,
            child: CustomPaint(
              painter: Bubble(
                radius: 30,
                color1: colorScheme.primaryContainer,
                color2: colorScheme.secondaryContainer,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.4,
            left: size.width * 0.4,
            child: CustomPaint(
              painter: Bubble(
                radius: 60,
                color1: colorScheme.primaryContainer,
                color2: colorScheme.secondaryContainer,
              ),
            ),
          ),
          Positioned(
            top: size.height * .1,
            left: size.width * .8,
            child: CustomPaint(
              painter: Bubble(
                radius: 170,
                color1: colorScheme.primaryContainer,
                color2: colorScheme.secondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Bubble extends CustomPainter {
  const Bubble(
      {required this.radius, required this.color2, required this.color1});
  final double radius;
  final Color color1;
  final Color color2;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [color1, color2],
      ).createShader(
        Rect.fromCircle(
          center: const Offset(0, 0),
          radius: radius,
        ),
      );

    canvas.drawCircle(const Offset(0, 0), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
