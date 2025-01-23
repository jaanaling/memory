import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nero/src/feature/rituals/utils/game_logic.dart';

import '../../../../ui_kit/app_icon_button.dart';
import '../../../core/utils/app_icon.dart';
import '../../../core/utils/icon_provider.dart';

class GameScreen extends StatefulWidget {
  final DifficultyLevel level;

  const GameScreen({super.key, required this.level});

  @override
  State<GameScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<GameScreen> {
  late List<CircleData> _circles;

  late int _timeLeft;
  bool _isMemorizationTime = true;

  Timer? _timer;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();

    _timeLeft = getMemorizationTime(widget.level);
    _generatePuzzle();
    _speakColorsSequentially();
    _startMemorizationTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _speakColorsSequentially() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5); // Ускоренная скорость речи
    await _flutterTts.setPitch(1.0); // Стандартная высота голоса

    for (final circle in _circles) {
      await _speakColor(circle.anounsmentColor.name);
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Минимальная пауза между цветами
    }
  }

  void _generatePuzzle() {
    final rand = Random();
    final numberOfCircles = getNumberOfCircles(widget.level);

    // Копируем доступные цвета
    final List<ColorData> availableColors = List.from(kAvailableColors);

    _circles = List.generate(numberOfCircles, (_) {
      // Перемешиваем доступные цвета для уникальности
      availableColors.shuffle(rand);

      // Гарантируем уникальность, выбирая по одному цвету для каждого параметра
      final fillColor = availableColors.removeAt(0);
      final textColor = availableColors.removeAt(0);
      final textName = availableColors.removeAt(0);
      final announcementColor = availableColors.removeAt(0);

      return CircleData(
        fillColor: fillColor,
        textColor: textColor,
        textName: textName,
        anounsmentColor: announcementColor,
      );
    });
  }

  void _startMemorizationTimer() {
    _timer = Timer.periodic(
        Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft--;
        if (_timeLeft <= 0) {
          _isMemorizationTime = false;
          _timer?.cancel();

          Future.microtask(() {
            context.pushReplacement('/home/answer',
                extra: {'level': widget.level, 'circles': _circles});
          });
        }
      });
    });
  }

  Future<void> _speakColor(String colorName) async {
    await _flutterTts.speak(colorName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            const Gap(15),
            Align(
              alignment: Alignment.topLeft,
              child: AppIconButton(
                child: AppIcon(asset: IconProvider.back.buildImageUrl()),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AppIcon(asset: IconProvider.titleBack.buildImageUrl()),
                  Text(
                    widget.level.name.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF13092A),
                      fontSize: 22,
                      fontFamily: 'Gunterz',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(18),
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(100, 100),
                  painter: PieChartPainter(
                    _timeLeft / getMemorizationTime(widget.level),
                    context,
                  ),
                ),
                Text(
                  '$_timeLeft sec',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _circles.map((circle) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipOval(
                      child: AppIcon(
                        asset: IconProvider.ball.buildImageUrl(),
                        width: 103,
                        height: 103,
                        color: circle.fillColor.color,
                        blendMode: BlendMode.modulate,
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      height: 103,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            circle.textName.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: circle.textColor.color,
                              fontSize:
                                  circle.textName.name.length > 7 ? 17 : 19,
                              fontFamily: 'Gunterz',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double value;
  final BuildContext context;

  PieChartPainter(this.value, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Background Section (Always full circle)
    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF3A006D), Color(0xFF3A006D)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * pi,
      false,
      backgroundPaint,
    );

    // Foreground Section (Yellow Arc)
    final sweepAngle = value * 2 * pi;
    final foregroundPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFFF00C7),
          Color(0xFFFF00C7),
        ],
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 17
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start at top center
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Перерисовка при изменении данных
  }
}
