import 'package:flutter/material.dart';
import 'package:nero/src/core/utils/app_icon.dart';
import 'package:nero/src/core/utils/icon_provider.dart';
import 'package:nero/src/core/utils/size_utils.dart';
import 'package:nero/ui_kit/animated_button.dart';

class HomeButton extends StatelessWidget {
  final HomeButtonType type;
  final VoidCallback onPressed;
  const HomeButton({super.key, required this.type, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 22),
            child: AppIcon(
              asset: IconProvider.homeButtonBack.buildImageUrl(),
              width: 263,
              height: 106,
            ),
          ),
          Positioned(
            left: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                width: 180,
                child: Center(
                  child: Text(
                    type.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'Gunterz',
                      fontWeight: FontWeight.w500,
                      height: 1.30,
                      letterSpacing: -1.05,
                      shadows: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 6.5,
                          spreadRadius: 15,
                          offset: Offset(
                            0.0,
                            0,
                          ),
                        ),
                        BoxShadow(
                          color: Color(0xFF0066FF),
                          blurRadius: 30.2,
                          spreadRadius: 15.0,
                          offset: Offset(
                            0.0,
                            0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: AppIcon(
              asset: IconProvider.iconBack.buildImageUrl(),
              width: 132.26,
              height: 110,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: AppIcon(
              asset: type.asset,
              width: 132.26,
              height: 110,
            ),
          ),
        ],
      ),
    );
  }
}

enum HomeButtonType {
  articles(asset: 'assets/images/articles.png', title: 'Articles'),
  start(asset: 'assets/images/start.png', title: 'start'),
  daily(asset: 'assets/images/daily_challenge.png', title: 'daily\nchallenge');

  const HomeButtonType({required this.asset, required this.title});

  final String asset;
  final String title;
}
