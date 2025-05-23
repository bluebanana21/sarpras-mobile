import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarpras_mobile/widgets/MainWrapper.dart';
import 'package:sarpras_mobile/screens/home.dart';
import 'package:sarpras_mobile/screens/itemPage.dart';

class NavigationController {
  NavigationController._();

  static String initial = "/home";

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(
    debugLabel: 'shellHome',
  );
  static final _shellNavigatorSettings = GlobalKey<NavigatorState>(
    debugLabel: 'shellSettings',
  );

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          /// Brach Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: "/home",
                name: "Home",
                builder:
                    (BuildContext context, GoRouterState state) => HomePage(),
                routes: [
                  GoRoute(
                    path: 'subHome',
                    name: 'subHome',
                    pageBuilder:
                        (context, state) => CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: const ItemPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                        ),
                  ),
                ],
              ),
            ],
          ),

          /// Brach Setting
        ],
      ),

      /// Player
    ],
  );
}
