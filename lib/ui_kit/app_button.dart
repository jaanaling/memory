import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inner_glow/inner_glow.dart';
import 'package:nero/src/core/utils/app_icon.dart';
import 'package:nero/src/core/utils/icon_provider.dart';
import 'package:nero/ui_kit/animated_button.dart';

class AppButton extends StatelessWidget {
  final String title;
  final ButtonColors color;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4150B6),
                  Color(0xFFFBF1CE),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: color == ButtonColors.purple
                        ? [
                            Color(0xFF4A36BD),
                            Color(0xFFEF5973),
                          ]
                        : [
                            Color(0xFF006DBB),
                            Color(0xFF1FCCBE),
                          ],
                  ),
                ),
                child: SizedBox(
                  width: 235,
                  height: 76,
                ),
              ),
            ),
          ),
          CustomPaint(
            foregroundPainter: BorderPainter(),
            child: Container(
              width: 235,
              height: 76,
              color: Colors.transparent,
            ),
          ),
          AppIcon(
            asset: IconProvider.hexagons.buildImageUrl(),
            width: 235,
            height: 76,
            fit: BoxFit.cover,
          ),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFFFFE7D4),
              fontSize: 22,
              fontFamily: 'Gunterz',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          )
        ],
      ),
    );
  }
}

enum ButtonColors { purple, blue }

class BorderPainter extends CustomPainter {
  final double lineLength; // Длина линий на углах

  BorderPainter({this.lineLength = 12}); // По умолчанию длина линии 20

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF6FCEFF) // Цвет линий на углах
      ..strokeWidth = 2 // Толщина линий
      ..style = PaintingStyle.stroke;

    Path path = Path();

    // Верхний левый угол
    path.moveTo(0, 0);
    path.lineTo(lineLength, 0); // Горизонтальная линия
    path.moveTo(0, 0);
    path.lineTo(0, lineLength); // Вертикальная линия

    // Верхний правый угол
    path.moveTo(size.width, 0);
    path.lineTo(size.width - lineLength, 0); // Горизонтальная линия
    path.moveTo(size.width, 0);
    path.lineTo(size.width, lineLength); // Вертикальная линия

    // Нижний левый угол
    path.moveTo(0, size.height);
    path.lineTo(lineLength, size.height); // Горизонтальная линия
    path.moveTo(0, size.height);
    path.lineTo(0, size.height - lineLength); // Вертикальная линия

    // Нижний правый угол
    path.moveTo(size.width, size.height);
    path.lineTo(size.width - lineLength, size.height); // Горизонтальная линия
    path.moveTo(size.width, size.height);
    path.lineTo(size.width, size.height - lineLength); // Вертикальная линия

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
