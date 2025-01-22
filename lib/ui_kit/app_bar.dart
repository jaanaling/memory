import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nero/src/core/utils/app_icon.dart';
import 'package:nero/src/core/utils/icon_provider.dart';
import 'package:nero/ui_kit/app_icon_button.dart';

class AppAppBar extends StatelessWidget {
  final int coinCount;
  final int tipsCount;
  const AppAppBar({super.key, required this.coinCount, required this.tipsCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppIconButton(
            onPressed: () {  },
            child: AppIcon(
          asset: IconProvider.achievements.buildImageUrl(),
          width: 35,
          height: 35,
        )),
        const Spacer(),
        AppIconButton(
            onPressed: () {  },
          width: 55,
            height: 86,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(
                  asset: IconProvider.coin.buildImageUrl(),
                  width: 40,
                  height: 35,
                ),
                Text(
                  '$coinCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )),
        Gap(10),
        AppIconButton(
            onPressed: () {  },
            width: 55,
            height: 86,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(
                  asset: IconProvider.tips.buildImageUrl(),
                  width: 30,
                  height: 45,
                ),
                Text(
                  '$tipsCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )),

      ],
    );
  }
}
