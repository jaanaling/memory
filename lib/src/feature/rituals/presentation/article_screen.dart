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
      ],
    );
  }
}

