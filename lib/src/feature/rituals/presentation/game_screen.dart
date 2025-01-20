import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nero/src/feature/rituals/utils/game_logic.dart';

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
          const Duration(milliseconds: 500)); // Минимальная пауза между цветами
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft--;
        if (_timeLeft <= 0) {
          _isMemorizationTime = false;
          _timer?.cancel();

          //  Future.microtask(() {
          //    context.pushReplacement();
          //  });
        }
      });
    });
  }

  Future<void> _speakColor(String colorName) async {
    await _flutterTts.speak(colorName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memorize Colors (${widget.level.name.toUpperCase()})'),
      ),
      body: Center(
        child: _isMemorizationTime
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Memorize for $_timeLeft seconds...',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: _circles.map((circle) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: circle.fillColor.color,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                circle.textName.name,
                                style: TextStyle(
                                  color: circle.textColor.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
