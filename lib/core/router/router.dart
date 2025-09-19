import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news/features/auth/presentation/pages/login/login.dart';
import 'package:news/features/auth/presentation/pages/login/reset_password/reset_password.dart';
import 'package:news/features/auth/presentation/pages/register/register.dart';
import 'package:news/features/history/presentation/pages/launcher.dart';
import 'package:news/features/main/data/model/model.dart';
import 'package:news/features/main/presentation/pages/main.dart';
import 'package:news/features/main/presentation/pages/news_details.dart';
import 'package:news/features/profile/presentation/pages/data/data.dart';
import 'package:news/features/profile/presentation/pages/launcher.dart';
import 'package:news/features/profile/presentation/pages/settings/settings.dart';
import 'package:news/features/profile/presentation/pages/support/support.dart';
import 'package:news/features/scaffold_with_nav_bar/scaffold_with_nav_bar.dart';
import 'package:news/features/search/presentation/pages/launcher.dart';
import 'package:news/injection.dart';
import 'package:talker_flutter/talker_flutter.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _mainNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'mainNav',
);
final GlobalKey<NavigatorState> _searchNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'searchNav',
);
final GlobalKey<NavigatorState> _favoritesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'favoritesNav');
final GlobalKey<NavigatorState> _profileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'profileNav');

class AppRouter {
  final GoRouter router = GoRouter(
    observers: [TalkerRouteObserver(getIt<Talker>())],
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/main',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),

        routes: <RouteBase>[
          GoRoute(
            path: 'reset_password',
            builder: (BuildContext context, GoRouterState state) {
              return const ResetPasswordPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterPage(),
      ),

      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return ScaffoldWithNavBar(navigationShell: navigationShell);
            },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            observers: [TalkerRouteObserver(getIt<Talker>())],
            navigatorKey: _mainNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/main',
                builder: (BuildContext context, GoRouterState state) =>
                    const MainPage(),
                routes: <GoRoute>[
                  GoRoute(
                    path: 'news/:id',
                    builder: (BuildContext context, GoRouterState state) {
                      final article = state.extra as ArticlesModel;
                      return NewsDetailsPage(article: article);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            observers: [TalkerRouteObserver(getIt<Talker>())],
            navigatorKey: _searchNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/search',
                builder: (BuildContext context, GoRouterState state) =>
                    const SearchLauncherPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            observers: [TalkerRouteObserver(getIt<Talker>())],
            navigatorKey: _favoritesNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/favorite',
                builder: (BuildContext context, GoRouterState state) =>
                    const HistoryLauncherPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            observers: [TalkerRouteObserver(getIt<Talker>())],
            navigatorKey: _profileNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/profile',
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfileLauncherPage(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'data',
                    builder: (BuildContext context, GoRouterState state) {
                      return const DataChangePage();
                    },
                  ),
                  GoRoute(
                    path: 'support',
                    builder: (BuildContext context, GoRouterState state) {
                      return const SupportPage();
                    },
                  ),
                  GoRoute(
                    path: 'settings',
                    builder: (BuildContext context, GoRouterState state) {
                      return const SettingsPage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
