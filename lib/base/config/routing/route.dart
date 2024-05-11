import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../calender/view_model/bindings/calender_binding.dart';
import '../../../calender/views/add_note_screen.dart';
import '../../../calender/views/calender_screen.dart';
import '../../../history/view/history_screen.dart';
import '../../../main/view_model/bindings/main_binding.dart';
import '../../../report_problem/views/report_problem.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouterProvider extends GetxController {
  final appRouter = GoRouter(
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
            MainBinding().dependencies();
            CalenderBinding().dependencies();
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
            return null;
          },
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CalenderScreen())),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(child: child);
        },
        routes: <RouteBase>[
          // GoRoute(
          //     path: '/home',
          //     redirect: (context, state) {
          //       SystemChrome.setSystemUIOverlayStyle(
          //           SystemUiOverlayStyle.light);
          //       return null;
          //     },
          //     parentNavigatorKey: _shellNavigatorKey,
          //     pageBuilder: (context, state) =>
          //         const NoTransitionPage(child: MainScreen())),
          // GoRoute(
          //     path: '/calender',
          //     redirect: (context, state) {
          //       SystemChrome.setSystemUIOverlayStyle(
          //           SystemUiOverlayStyle.light);
          //       return null;
          //     },
          //     parentNavigatorKey: _shellNavigatorKey,
          //     pageBuilder: (context, state) =>
          //         const NoTransitionPage(child: CalenderScreen())),
          GoRoute(
              path: '/addNote',
              redirect: (context, state) {
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light);
                return null;
              },
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AddNoteScreen())),
          GoRoute(
              path: '/history',
              redirect: (context, state) {
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light);
                return null;
              },
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HistoryScreen())),
          GoRoute(
              path: '/reportProBlem',
              redirect: (context, state) {
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light);
                return null;
              },
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ReportProBlem()))
        ],
      ),
    ],
  );
  @override
  void onInit() {
    appRouter;
    super.onInit();
  }
}
