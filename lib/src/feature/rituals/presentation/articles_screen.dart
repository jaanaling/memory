import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nero/routes/route_value.dart';
import 'package:nero/src/core/utils/app_icon.dart';
import 'package:nero/src/core/utils/icon_provider.dart';
import 'package:nero/src/feature/rituals/bloc/user_bloc.dart';
import 'package:nero/src/feature/rituals/model/article.dart';
import 'package:nero/ui_kit/animated_button.dart';

import '../../../../ui_kit/app_icon_button.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return SingleChildScrollView(
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
                          AppIcon(asset: IconProvider.titleBack.buildImageUrl()),
                          Text(
                            'ARTICLES',
                            style: TextStyle(
                              color: Color(0xFF13092A),
                              fontSize: 22,
                              fontFamily: 'Gunterz',
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        ],
                      ),
                    ),
                    Gap(29),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            _ArticleItem(article: state.articles[index]),
                        separatorBuilder: (BuildContext context, int index) =>
                            Gap(20),
                        itemCount: state.articles.length)
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF00FB),
            ),
          );
        }
      },
    );
  }
}

class _ArticleItem extends StatelessWidget {
  final Article article;

  const _ArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: (){
        context.push('${RouteValue.articles.path}/${RouteValue.article.path}', extra: article);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AppIcon(
            asset: IconProvider.articlesButton.buildImageUrl(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              article.title,
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
          Gap(20),
        ],
      ),
    );
  }
}
