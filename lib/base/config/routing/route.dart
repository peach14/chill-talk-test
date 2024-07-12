import 'package:chill_talk_test/auth/views/login_screen.dart';
import 'package:chill_talk_test/base/config/routing/route_path.dart';
import 'package:chill_talk_test/calender/views/detail_calender_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/view_model/bindings/login_binding.dart';
import '../../../auth/view_model/login_view_model.dart';
import '../../../calender/views/add_note_screen.dart';
import '../../../calender/views/calender_screen.dart';
import '../../../history/view/history_screen.dart';
import '../../../main/view_model/bindings/main_binding.dart';
import '../../../main/views/main_screen.dart';
import '../../../report_problem/views/report_problem_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

//class AppRouterProvider extends GetxController {
final appRouter = GoRouter(
  errorBuilder: (ctx, state) => Scaffold(
    body: Center(
      child: Text('Error Route: ${state.error}'),
    ),
  ),
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
        path: kNevDefault,
        redirect: (context, state) async {
          //  final token = await Get.find<SplashViewModel>().token();
          // if (token == kNoSuccessToken) {
          //   context.go(kNevLogin);
          // }
          // if (token == keySuccessToken) {
          //   context.go(kNevMain);
          // }
          //    MainBinding().dependencies();
          //    SplashBinding().dependencies();
          LoginBinding().dependencies();
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
          return null;
        },
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginScreen()
                //  MainScreen()
                // SplashScreen()
                )),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
            path: kNevLogin,
            redirect: (context, state) {
              LoginBinding().dependencies();

              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
              return null;
            },
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LoginScreen())),
        GoRoute(
          path: kNevMain,
          redirect: (context, state) {
            MainBinding().dependencies();
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
            return null;
          },
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MainScreen()),
        ),
        // GoRoute(
        //   path: "horizontal",
        //   redirect: (context, state) {
        //     MainBinding().dependencies();
        //     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        //     return null;
        //   },
        //   parentNavigatorKey: _shellNavigatorKey,
        //   pageBuilder: (context, state) =>
        //       const NoTransitionPage(child: MainHorizontalScreen()),
        // ),
        GoRoute(
            path: kNevCalender,
            redirect: (context, state) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
              return null;
            },
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CalenderScreen())),
        GoRoute(
            path: kNevAddNote,
            redirect: (context, state) {
              Get.lazyPut(() => LoginViewModel());

              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
              return null;
            },
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: AddNoteScreen())),
        GoRoute(
            path: kNevDetail,
            redirect: (context, state) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
              return null;
            },
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DetailCalenderScreen())),
        GoRoute(
            path: kNevHistory,
            redirect: (context, state) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
              return null;
            },
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HistoryScreen())),
        GoRoute(
            path: kNevReportProBlem,
            redirect: (context, state) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
              return null;
            },
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ReportProblemScreen()))
      ],
    ),
  ],
);
// @override
// void onInit() {
//   appRouter;
//   super.onInit();
// }
//}
