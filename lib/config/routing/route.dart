import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/views/login_screen.dart';
import '../../features/main/views/home_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    errorBuilder: (ctx, state) => Scaffold(
      body: Center(
        child: Text('Error Route: ${state.error}'),
      ),
    ),
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
          path: '/',
          redirect: (context, state) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
            return null;
          },
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LoginScreen())),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
              path: '/home',
              redirect: (context, state) {
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light);
                return null;
              },
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomeScreen())),
        ],
      ),
    ],
  );
});
