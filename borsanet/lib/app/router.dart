import 'package:borsanet/views/app_view.dart';
import 'package:borsanet/views/screens/analyst_view/analyst_view.dart';
import 'package:borsanet/views/screens/analyst_view/analyst_viewmodel.dart';
import 'package:borsanet/views/screens/detail_view/detail_view.dart';
import 'package:borsanet/views/screens/detail_view/detail_viewmodel.dart';
import 'package:borsanet/views/screens/favourites_view/favourites_view.dart';
import 'package:borsanet/views/screens/favourites_view/favourites_viewmodel.dart';
import 'package:borsanet/views/screens/news_view/news_view.dart';
import 'package:borsanet/views/screens/news_view/news_viewmodel.dart';
import 'package:borsanet/views/screens/profile_view/profile_view.dart';
import 'package:borsanet/views/screens/profile_view/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _routerKey = GlobalKey<NavigatorState>();

final _shellNavigatorNewsKey =
    GlobalKey<NavigatorState>(debugLabel: "shellNews");
final _shellNavigatorAnalystKey =
    GlobalKey<NavigatorState>(debugLabel: "shellAnalyst");
final _shellNavigatorFavouritesKey =
    GlobalKey<NavigatorState>(debugLabel: "shellFavourites");

class AppRoutes {
  AppRoutes._();

  static const String news = "/news";
  static const String analyst = "/analyst";
  static const String favourites = "/favourites";
  static const String profile = "/profile";

  static const String detail = "detail";
}

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.news, // welcome page yaz
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppView(navigationShell: navigationShell);
      },
      branches: [
        // news
        StatefulShellBranch(
          navigatorKey: _shellNavigatorNewsKey,
          routes: [
            GoRoute(
              path: AppRoutes.news,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => NewsViewmodel(),
                child: const NewsView(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.detail,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => DetailViewmodel(),
                    child: DetailView(name: state.extra as String),
                  ),
                )
              ],
            ),
          ],
        ),
     // analyst
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAnalystKey,
          routes: [
            GoRoute(
              path: AppRoutes.analyst,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => AnalystViewmodel(),
                child: const AnalystView(),
              ),
              routes: [
        GoRoute(
          path: AppRoutes.detail,
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => DetailViewmodel(),
            child: DetailView(name: state.extra as String),
          ),
        ),
      ],
              
            ),
          ],
        ),
        // favourites
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFavouritesKey,
          routes: [
            GoRoute(
              path: AppRoutes.favourites,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => FavouritesViewmodel(),
                child: const FavouritesView(),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => ProfileViewmodel(),
        child: const ProfileView(),
      ),
    ),
  ],
);
