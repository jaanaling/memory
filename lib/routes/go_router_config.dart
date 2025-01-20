import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nero/src/feature/rituals/presentation/answer_screen.dart';
import 'package:nero/src/feature/rituals/presentation/home_screen.dart';
import 'package:nero/src/feature/rituals/utils/game_logic.dart';

import '../src/feature/splash/presentation/screens/splash_screen.dart';
import 'root_navigation_screen.dart';
import 'route_value.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildGoRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteValue.home.path,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          child: RootNavigationScreen(
            navigationShell: navigationShell,
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouteValue.home.path,
              builder: (BuildContext context, GoRouterState state) {
                return AnswerScreen(circles: [
                  CircleData(
                      fillColor:
                          ColorData(name: 'Red', color: Color(0xFFFF0000)),
                      textColor:
                          ColorData(name: 'Green', color: Color(0xFF008000)),
                      textName:
                          ColorData(name: 'Blue', color: Color(0xFF0000FF)),
                      anounsmentColor:
                          ColorData(name: 'Yellow', color: Color(0xFFFFFF00))),
                  CircleData(
                      fillColor:
                          ColorData(name: 'Green', color: Color(0xFF008000)),
                      textColor:
                          ColorData(name: 'Blue', color: Color(0xFF0000FF)),
                      textName:
                          ColorData(name: 'Red', color: Color(0xFFFF0000)),
                      anounsmentColor:
                          ColorData(name: 'White', color: Color(0xFFFFFFFF))),
                ], hintsLeft: 5);
              },
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.black,
            child: child,
          ),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteValue.splash.path,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
      ],
    ),
  ],
);
