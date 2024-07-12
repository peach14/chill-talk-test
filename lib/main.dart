import 'package:chill_talk_test/main/view_model/bindings/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'base/config/routing/route.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter's binding system is initialized
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  initializeDateFormatting('th', null).then((_) {
    runApp(const MyApp.native());
  });
}

class MyApp extends GetView {
  final bool isDevicePreview;
  const MyApp.native({super.key}) : isDevicePreview = false;

  const MyApp.devicePreview({super.key}) : isDevicePreview = true;

  @override
  Widget build(BuildContext context) {
    // Get.put(AppRouterProvider());
    // final route = Get.find<AppRouterProvider>();
    return GetMaterialApp.router(
      initialBinding: AppBinding(),
      locale: const Locale('th', 'TH'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('th', 'TH'),
      ],
      // routeInformationParser: appRouter.routeInformationParser,
      // routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routerDelegate: appRouter.routerDelegate,
      routeInformationProvider: appRouter.routeInformationProvider,
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 320,
          defaultScale: true,
          breakpoints: [
            // const ResponsiveBreakpoint.autoScale(600),
            const ResponsiveBreakpoint.resize(320, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(540, name: TABLET),
            //    const ResponsiveBreakpoint.autoScale(1200, name: TABLET),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xff1a6cae)),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
    );
  }
}
