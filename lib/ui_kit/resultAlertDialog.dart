import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nero/ui_kit/app_button.dart';

import '../src/core/utils/app_icon.dart';
import '../src/core/utils/icon_provider.dart';
import '../src/feature/rituals/utils/game_logic.dart';
import 'animated_button.dart';

void showResultDialog(BuildContext context, bool result) {
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 31),
                    child: AppIcon(
                      asset: IconProvider.alertDialogBack.buildImageUrl(),
                      width: 308,
                      height: 448,
                    ),
                  ),
                  Positioned(
                    top: 11,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AppIcon(
                          asset: IconProvider.titleBack.buildImageUrl(),
                          width: 310,
                          height: 65.2,
                        ),
                        Text(
                          result ? 'YOU WIN!' : 'don’t give up!',
                          style: TextStyle(
                            color: Color(0xFF13092A),
                            fontSize: 22,
                            fontFamily: 'Gunterz',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 95),
                    child: Column(
                      children: [
                        if (result)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppIcon(
                                asset: IconProvider.coin.buildImageUrl(),
                                width: 87.57,
                                height: 76.63,
                              ),
                              Text(
                                '10',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'New record!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        if (!result)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 242,
                                child: Text(
                                  'Tip: try focusing on one aspect - color or text',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Gap(20),
                              SizedBox(
                                width: 242,
                                child: Text(
                                  'Record: Stage 10',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButton(
                            color: ButtonColors.purple,
                            onPressed: () {},
                            title: result ? 'next stage' : 'try again'),
                        Gap(20),
                        AppButton(
                            color: ButtonColors.blue,
                            onPressed: () {},
                            title: 'main menu'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
