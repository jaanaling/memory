import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nero/src/core/utils/app_icon.dart';
import 'package:nero/src/core/utils/icon_provider.dart';
import 'package:nero/src/feature/rituals/bloc/user_bloc.dart';
import 'package:nero/src/feature/rituals/utils/game_logic.dart';
import 'package:nero/ui_kit/animated_button.dart';
import 'package:nero/ui_kit/app_bar.dart';
import 'package:nero/ui_kit/buy_hint_alert_dialog.dart';

import '../../../../ui_kit/app_icon_button.dart';
import '../../../../ui_kit/resultAlertDialog.dart';

class AnswerScreen extends StatefulWidget {
  final List<CircleData> circles;
  final DifficultyLevel difficulty;

  const AnswerScreen({
    super.key,
    required this.difficulty,
    required this.circles,
  });

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  late List<ColorData> _choices;

  late String _taskDescription;
  late Set<ColorData> _selectedColors;

  @override
  void initState() {
    super.initState();

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

  void _useHint(int hints) {
    if (hints <= 0) {
      showHintUnavailableDialog(context);
      return;
    }

    final correctColors = _getCorrectColorsByTask();

    setState(() {
      context.read<UserBloc>().add(UserHintUsed());

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
      showResultDialog(context, isCorrect, widget.difficulty);
      context.read<UserBloc>().add(UserPuzzleSolved(
          isCorrect: isCorrect, difficulty: widget.difficulty));
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final user = state.user;
        final hintsRemaining = user.hints ;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                Gap(15),
                AppAppBar(
                  coinCount: user.coins,
                  tipsCount: hintsRemaining,
                  hasBackButton: true,
                ),
                const SizedBox(height: 35),
                Text(
                  _taskDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Gunterz',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 11),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIconButton(
                          onPressed: () {
                            _useHint(hintsRemaining);
                          },
                          child: AppIcon(
                            asset: IconProvider.tips.buildImageUrl(),
                            width: 30,
                            height: 45,
                          )),
                      Text(
                        'use hint',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: _choices.map((colorData) {
                    final isSelected = _selectedColors.contains(colorData);

                    return AnimatedButton(
                      onPressed: () {
                        _toggleSelection(colorData);
                        _checkAnswer();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 109,
                            height: 109,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: isSelected
                                      ? Border.all(
                                          color: Colors.blueAccent,
                                          width: 3) // Рамка для выделенных
                                      : null,
                                ),
                                child: ClipOval(
                                  child: AppIcon(
                                    asset: IconProvider.ball.buildImageUrl(),
                                    width: 103,
                                    height: 103,
                                    color: colorData.color,
                                    blendMode: BlendMode.modulate,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            height: 103,
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  colorData.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        colorData.color.computeLuminance() > 0.5
                                            ? Colors.black
                                            : Colors.white,
                                    fontSize: 19,
                                    fontFamily: 'Gunterz',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Spacer()
              ],
            ),
          ),
        );
      },
    );
  }
}
