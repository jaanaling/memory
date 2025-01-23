import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inner_glow/inner_glow.dart';
import 'package:nero/ui_kit/animated_button.dart';

class AppIconButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  const AppIconButton(
      {super.key,
      required this.child,
      this.width = 62,
      this.height = 62,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return onPressed != null
        ? AnimatedButton(
            onPressed: onPressed!,
            child: content(),
          )
        : content();
  }

  Widget content() {
    return Stack(
      children: [
        InnerGlow(
          width: width,
          height: height,
          glowRadius: 13,
          thickness: 10,
          glowBlur: 5,
          strokeLinearGradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF4B3FE2), Color(0xFF4B3FE2)],
          ),
          baseDecoration: BoxDecoration(
            border: Border.all(color: const Color(0xC7753FE2), width: 1),
            borderRadius: BorderRadius.circular(13),
            color: const Color(0xFF280178),
          ),
          child: Center(
            child: child,
          ),
        ),
        CustomPaint(
          foregroundPainter:
              BorderPainter(borderRadius: BorderRadius.circular(13)),
          child: Container(
            width: width,
            height: height,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class BorderPainter extends CustomPainter {
  final BorderRadius borderRadius;

  BorderPainter({required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // высота
    double sw = size.width; // ширина

    Paint paint = Paint()
      ..color = const Color(0xFF753FE2)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Получаем радиусы для каждого угла
    double topLeft = borderRadius.topLeft.x;
    double topRight = borderRadius.topRight.x;
    double bottomLeft = borderRadius.bottomLeft.x;
    double bottomRight = borderRadius.bottomRight.x;

    Path path = Path()
      // Верхний левый угол
      ..moveTo(topLeft, 0)
      ..quadraticBezierTo(0, 0, 0, topLeft)
      // Нижний левый угол
      ..moveTo(0, sh - bottomLeft)
      ..quadraticBezierTo(0, sh, bottomLeft, sh)
      // Нижний правый угол
      ..moveTo(sw - bottomRight, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - bottomRight)
      // Верхний правый угол
      ..moveTo(sw, topRight)
      ..quadraticBezierTo(sw, 0, sw - topRight, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant BorderPainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
