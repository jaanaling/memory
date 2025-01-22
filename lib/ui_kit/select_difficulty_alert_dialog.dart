import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nero/src/core/utils/app_icon.dart';
import 'package:nero/src/core/utils/icon_provider.dart';

void showDifficultAlertDialog(BuildContext context, bool isEnough) {
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
              children: [
                AppIcon(
                  asset: IconProvider.alertDialogBack.buildImageUrl(),
                  width: 308,
                  height: 448,
                ),
                Positioned(
                    left: -57.37,
                    top: 11,
                    child:
                        AppIcon(asset: IconProvider.titleBack.buildImageUrl())),
                Column(
                  children: [],
                )
              ],
            ),
          ));
    },
  );
}
