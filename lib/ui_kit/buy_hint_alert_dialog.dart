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

void showBuyHintAlertDialog(BuildContext context) {
  DifficultyLevel? level; // Начальный текст кнопки

  showDialog(
    context: context,
    builder: (BuildContext context) {
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
                      'buy hint',
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
                    child: AppIcon(asset: IconProvider.close.buildImageUrl()),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 95),
                child: Column(
                  children: [
                    AppIcon(
                      asset: IconProvider.coin.buildImageUrl(),
                      width: 110.82,
                      height: 96.97,
                    ),
                    Text(
                      '10',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 47,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    AppButton(
                        color: ButtonColors.purple,
                        onPressed: () {},
                        title: 'buy'),
                    Gap(27)
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showHintUnavailableDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
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
                      'no hints left',
                      style: TextStyle(
                        color: Color(0xFF13092A),
                        fontSize: 20,
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
                    child: AppIcon(asset: IconProvider.close.buildImageUrl()),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 95),
                child: Column(
                  children: [
                    AppIcon(
                      asset: IconProvider.tips.buildImageUrl(),
                      width: 110.82,
                      height: 96.97,
                    ),
                    Text(
                      'You have used all your hints.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    AppButton(
                        color: ButtonColors.purple,
                        onPressed: () {
                          context.pop();
                        },
                        title: 'ok'),
                    Gap(27)
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
