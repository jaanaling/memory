import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nero/routes/go_router_config.dart';
import 'package:nero/src/core/utils/app_icon.dart';
import 'package:nero/src/core/utils/icon_provider.dart';
import 'package:nero/src/core/utils/size_utils.dart';
import 'package:nero/src/feature/rituals/model/article.dart';
import 'package:nero/ui_kit/app_icon_button.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;
  const ArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Gap(15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: AppIconButton(
                        child: AppIcon(asset: IconProvider.back.buildImageUrl()),
                        onPressed: () {
                          context.pop();
                        }),
                  ),
                  Gap(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AppIcon(asset: IconProvider.titleBack.buildImageUrl(), width: getWidth(context, percent: 1)-19, fit: BoxFit.fill,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 43),
                          child: Text(
                            article.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF13092A),
                              fontSize: article.title.length>25?15:21,
                              fontFamily: 'Gunterz',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Gap(45),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      article.content,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Gap(20),
                ],
              ),
            ),
          ),
        ),
        AppContainer()
      ],
    );
  }
}

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 308,
      height: 448,
      child: Stack(
        children: [
          Positioned(
            left: 2.01,
            top: 2,
            child: Container(
              width: 303.97,
              height: 444,
              decoration: ShapeDecoration(
                color: Color(0x441F004C),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF30428A),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 2.01,
            top: 2,
            child: Container(
              width: 303.97,
              height: 444,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 303.97,
                      height: 444,
                      decoration: BoxDecoration(color: Color(0xFF1F004C)),
                    ),
                  ),
                  Positioned(
                    left: -58.38,
                    top: -83,
                    child: Opacity(
                      opacity: 0.55,
                      child: Container(
                        width: 416.71,
                        height: 148,
                        decoration: ShapeDecoration(
                          color: Color(0xFFB82A9E),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -58.38,
                    top: 382,
                    child: Opacity(
                      opacity: 0.55,
                      child: Container(
                        width: 416.71,
                        height: 148,
                        decoration: ShapeDecoration(
                          color: Color(0xFF902AB8),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 334.17,
                    top: -10,
                    child: Opacity(
                      opacity: 0.55,
                      child: Transform(
                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
                        child: Container(
                          width: 489,
                          height: 52.34,
                          decoration: ShapeDecoration(
                            color: Color(0xFF2A89B8),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15.10,
                    top: -10,
                    child: Opacity(
                      opacity: 0.55,
                      child: Transform(
                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
                        child: Container(
                          width: 489,
                          height: 52.34,
                          decoration: ShapeDecoration(
                            color: Color(0xFF2A89B8),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 295.92,
            top: 436,
            child: Container(
              width: 12.08,
              height: 12,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.transparent),
                  top: BorderSide(color: Colors.transparent),
                  right: BorderSide(width: 2, color: Color(0xFF6ECDFF)),
                  bottom: BorderSide(width: 2, color: Color(0xFF6ECDFF)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 12.08,
            top: 436,
            child: Transform(
              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
              child: Container(
                width: 12.08,
                height: 12,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.transparent),
                    top: BorderSide(color: Colors.transparent),
                    right: BorderSide(width: 2, color: Color(0xFF6ECDFF)),
                    bottom: BorderSide(width: 2, color: Color(0xFF6ECDFF)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 12.08,
            top: 12,
            child: Transform(
              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
              child: Container(
                width: 12.08,
                height: 12,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.transparent),
                    top: BorderSide(color: Colors.transparent),
                    right: BorderSide(width: 2, color: Color(0xFF6ECDFF)),
                    bottom: BorderSide(width: 2, color: Color(0xFF6ECDFF)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 295.92,
            top: 12,
            child: Container(
              width: 12.08,
              height: 12,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.transparent),
                  top: BorderSide(color: Colors.transparent),
                  right: BorderSide(width: 2, color: Color(0xFF6ECDFF)),
                  bottom: BorderSide(width: 2, color: Color(0xFF6ECDFF)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

