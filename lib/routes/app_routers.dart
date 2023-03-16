import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../app/home/presentation/screens/home_screen.dart';
import 'routes.dart';

class AppRoutes {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routers.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
  );
  static GoRouter get router => _router;
}
