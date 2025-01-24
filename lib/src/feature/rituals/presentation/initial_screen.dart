import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nero/routes/go_router_config.dart';
import 'package:nero/src/feature/rituals/bloc/user_bloc.dart';
import 'package:nero/src/feature/rituals/utils/game_logic.dart';
import 'package:nero/ui_kit/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_icon.dart';
import '../../../core/utils/icon_provider.dart';

class InitialScreen extends StatefulWidget {
  final DifficultyLevel level;
  final int stage;

  const InitialScreen({super.key, required this.level, required this.stage});

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int countdown = 0;
  bool showCountdown = false;
  bool showOverlay = true;
  bool isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final firstLaunch = await UserPreferences.isFirstLaunch();
    setState(() {
      isFirstLaunch = firstLaunch;
    });
    if (firstLaunch) {
      await UserPreferences.setFirstLaunchDone();
    }
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

        return Stack(
          alignment: Alignment.center,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    const Gap(15),
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
                    const Gap(13),
                    Text(
                      'stage ${state.user.consecutivePuzzlesSolved+1}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 305,
                      child: const Text(
                        'Watch carefully and memorize the colors!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 31,
                          fontFamily: 'Gunterz',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Spacer(),
                    if (showCountdown)
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          countdown > 0 ? '$countdown' : 'GO!',
                          key: ValueKey(
                              countdown), // Ключ для идентификации текущего текста
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontFamily: 'Gunterz',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const Spacer(),
                    if (!showCountdown)
                      AppButton(
                        color: ButtonColors.purple,
                        title: 'READY',
                        onPressed: () {
                          startCountdown(widget.level);
                        },
                      ),
                    const Gap(69),
                  ],
                ),
              ),
            ),
            if (isFirstLaunch)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black.withOpacity(0.85),
                ),
              ),
            if (isFirstLaunch)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to the Color Memory Challenge!\n\n'
                          'Here’s how the game works:\n\n'
                          'During the game, you’ll see a colored ball, a text label, and hear a spoken color.\n\n'
                          '⚠️ Important: The ball\'s color, the written text, and the color of the text will not match. Pay close attention!\n\n'
                          'Your task is to remember all the colors shown and heard during the game.\n\n'
                          'On the answer screen, you’ll get a specific task that tells you how to choose the correct colors.\n\n'
                          '🎯 For example, you might need to pick the ball’s color, the spoken color, or the text color.\n\n'
                          '🕒 Tip: The memory phase has a time limit, but you can take your time to answer carefully.\n\n'
                          'Focus, memorize, and test your skills! Good luck!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      color: ButtonColors.purple,
                      title: 'OK',
                      onPressed: () {
                        setState(() {
                          isFirstLaunch = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  void startCountdown(DifficultyLevel level) {
    setState(() {
      showCountdown = true;
      countdown = 3;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        countdown = 2;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        countdown = 1;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        countdown = 0; // "GO!"
      });
    });

    Future.delayed(const Duration(seconds: 4), () {
      // Переход на другой экран
      context.pushReplacement('/home/game', extra: level);
    });
  }
}

class UserPreferences {
  static const String _keyFirstLaunch = 'isFirstLaunch';

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFirstLaunch) ?? true; // По умолчанию true
  }

  static Future<void> setFirstLaunchDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstLaunch, false);}}

