import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nero/routes/go_router_config.dart';
import 'package:nero/routes/route_value.dart';
import 'package:nero/src/core/utils/app_icon.dart';
import 'package:nero/src/core/utils/icon_provider.dart';
import 'package:nero/src/core/utils/size_utils.dart';
import 'package:nero/src/feature/rituals/bloc/user_bloc.dart';
import 'package:nero/src/feature/rituals/utils/game_logic.dart';
import 'package:nero/ui_kit/app_bar.dart';
import 'package:nero/ui_kit/app_icon_button.dart';
import 'package:nero/ui_kit/home_button.dart';
import 'package:nero/ui_kit/select_difficulty_alert_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          children: [
            AppIcon(
              asset: IconProvider.backgroundHome.buildImageUrl(),
              width: getWidth(context, percent: 1),
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Gap(15),
                      AppAppBar(
                          coinCount: state.user.coins,
                          tipsCount: state.user.hints),
                      Gap(15),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          AppIcon(
                            asset: IconProvider.mainBall.buildImageUrl(),
                            width: 181,
                            height: 181,
                          ),
                          Text(
                            'WHITE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 37,
                              fontFamily: 'Gunterz',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Gap(12),
                      Text(
                        'Challenge your mind every day!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(35),
                      HomeButton(
                        type: HomeButtonType.articles,
                        onPressed: () {
                          context.push(RouteValue.articles.path);
                        },
                      ),
                      Gap(15),
                      HomeButton(
                        type: HomeButtonType.start,
                        onPressed: () {
                          showDifficultAlertDialog(context);
                        },
                      ),
                      Gap(15),
                      HomeButton(
                        type: HomeButtonType.daily,
                        onPressed: () {
                          context.push(
                              '${RouteValue.home.path}/${RouteValue.initial.path}',
                              extra: {
                                'level': DifficultyLevel.extreme,
                                'stage': 1
                              });
                        },
                      ),
                      Gap(12),
                      Text(
                        'Daily tip: ${shortTips[DateTime.now().weekday - 1]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
