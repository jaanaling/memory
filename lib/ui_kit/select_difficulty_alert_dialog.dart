import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nero/routes/go_router_config.dart';
import 'package:nero/routes/route_value.dart';
import 'package:nero/src/core/utils/app_icon.dart';
import 'package:nero/src/core/utils/icon_provider.dart';
import 'package:nero/src/feature/rituals/utils/game_logic.dart';
import 'package:nero/ui_kit/animated_button.dart';
import 'package:nero/ui_kit/app_button.dart';

void showDifficultAlertDialog(BuildContext context) {
  DifficultyLevel? level; // Начальный текст кнопки

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: SizedBox(
              width: 308,
              height: 448,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AppIcon(
                    asset: IconProvider.alertDialogBack.buildImageUrl(),
                    width: 308,
                    height: 448,
                  ),
                  Positioned(
                    left: -57.37,
                    top: 11,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AppIcon(
                          asset: IconProvider.titleBack.buildImageUrl(),
                          width: 310,
                          height: 65.2,
                        ),
                        const Text(
                          'Select \ndifficulty',
                          style: TextStyle(
                            color: Color(0xFF13092A),
                            fontSize: 22,
                            fontFamily: 'Gunterz',
                            fontWeight: FontWeight.w500,
                            height: 0.95,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 9,
                    right: 11,
                    child: AnimatedButton(
                        child:
                            AppIcon(asset: IconProvider.close.buildImageUrl()),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 95),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AnimatedButton(
                              onPressed: () {
                                setState(() {
                                  level = DifficultyLevel.easy;
                                });
                              },
                              child: ClipOval(
                                child: AppIcon(
                                  asset: IconProvider.mainBall.buildImageUrl(),
                                  width: 76,
                                  height: 76,
                                  color: const Color(0xFF12fc06),
                                  blendMode: BlendMode.color,
                                ),
                              ),
                            ),
                            AnimatedButton(
                              onPressed: () {
                                setState(() {
                                  level = DifficultyLevel.medium;
                                });
                              },
                              child: ClipOval(
                                child: AppIcon(
                                  asset: IconProvider.mainBall.buildImageUrl(),
                                  width: 76,
                                  height: 76,
                                  color: const Color(0xFFfa9500),
                                  blendMode: BlendMode.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(41),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AnimatedButton(
                              onPressed: () {
                                setState(() {
                                  level = DifficultyLevel.hard;
                                });
                              },
                              child: ClipOval(
                                child: AppIcon(
                                  asset: IconProvider.mainBall.buildImageUrl(),
                                  width: 76,
                                  height: 76,
                                  color: const Color(0xFFff2527),
                                  blendMode: BlendMode.color,
                                ),
                              ),
                            ),
                            AnimatedButton(
                              onPressed: () {
                                setState(() {
                                  level = DifficultyLevel.extreme;
                                });
                              },
                              child: AppIcon(
                                asset: IconProvider.mainBall.buildImageUrl(),
                                width: 76,
                                height: 76,
                              ),
                            ),
                          ],
                        ),
                        const Gap(38),
                        if (level != null)
                          AppButton(
                            color: ButtonColors.purple,
                            title:
                                'Start: ${level!.name}', // Отображение выбранного текста
                            onPressed: () {
                              context.pop();
                              context.push(
                                  '${RouteValue.home.path}/${RouteValue.initial.path}',
                                  extra: {'level': level, 'stage': 1});
                            },
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
