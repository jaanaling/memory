import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nero/src/feature/rituals/utils/game_logic.dart';

class AnswerScreen extends StatefulWidget {
  final List<CircleData> circles;

  final int hintsLeft;

  const AnswerScreen({
    super.key,
    required this.circles,
    required this.hintsLeft,
  });

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  late List<ColorData> _choices;
  late int _hintsRemaining;
  late String _taskDescription;
  late Set<ColorData> _selectedColors;

  @override
  void initState() {
    super.initState();
    _hintsRemaining = widget.hintsLeft;
    _taskDescription = getTaskDescription();
    _generateChoices();
    _selectedColors = {}; 
  }

  void _generateChoices() {
    final rand = Random();
    final List<ColorData> shuffledColors = List.from(kAvailableColors)
      ..shuffle(rand);

    final correctColors = _getCorrectColorsByTask();

    _choices = [
      ...correctColors,
      ...shuffledColors
          .where((color) => !correctColors.contains(color))
          .take(9 - correctColors.length)
    ]..shuffle(rand);
  }

  Set<ColorData> _getCorrectColorsByTask() {
    switch (_taskDescription) {
      case "Select the circles' FILL color":
        return widget.circles.map((circle) => circle.fillColor).toSet();
      case "Select the circles' TEXT color":
        return widget.circles.map((circle) => circle.textColor).toSet();
      case 'Select the color that was ANNOUNCED by voice':
        return widget.circles
            .map((circle) => circle.anounsmentColor)
            .toSet(); // Пример: один цвет из озвученного
      case "Select the circles' TEXT name":
        return widget.circles.map((circle) => circle.textName).toSet();
      default:
        return {};
    }
  }

  void _useHint() {
    if (_hintsRemaining <= 0) {
      _showHintUnavailableDialog();
      return;
    }

    final correctColors = _getCorrectColorsByTask();

    setState(() {
      _hintsRemaining--;

      final wrongColor = _choices.firstWhere(
        (color) => !correctColors.contains(color),
      );

      _choices.remove(wrongColor);
      _selectedColors.remove(wrongColor);
    });
  }

  void _checkAnswer() {
    final correctColors = _getCorrectColorsByTask();
    final isCorrect = _selectedColors.containsAll(correctColors) &&
        correctColors.containsAll(_selectedColors);

    if (_selectedColors.length == widget.circles.length) {
      _showResultDialog(isCorrect);
    }
  }

  void _toggleSelection(ColorData colorData) {
    setState(() {
      if (_selectedColors.contains(colorData)) {
        _selectedColors.remove(colorData); // Снимаем выбор
      } else {
        _selectedColors.add(colorData); // Выбираем элемент
      }
    });
  }

  void _showResultDialog(bool isCorrect) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Wrong!'),
        content: Text(
          isCorrect
              ? 'Good job! You selected all the correct circles.'
              : 'That is not correct. Try again.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              if (isCorrect) context.pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showHintUnavailableDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('No Hints Left'),
        content: const Text('You have used all your hints.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select the Answer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _useHint,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Hints: $_hintsRemaining',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            _taskDescription,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: _choices.map((colorData) {
                final isSelected = _selectedColors.contains(colorData);

                return GestureDetector(
                  onTap: () {
                    _toggleSelection(colorData);
                    _checkAnswer();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorData.color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        colorData.name,
                        style: TextStyle(
                          color: colorData.color.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
