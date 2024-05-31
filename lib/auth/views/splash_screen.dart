import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/component/loading.dart';
import '../view_model/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashViewModel _splashViewModel = Get.put(SplashViewModel());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _splashViewModel.checkTokenAndNavigate(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: const Color(0xff1a6cae),
      body: Center(
        child: Stack(alignment: Alignment.center, children: [
          //  const Loading(),
          Column(
            children: [
              const Spacer(),
              Expanded(
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: Container(
                          decoration: BoxDecoration(
                              //  color: const Color.fromARGB(255, 246, 243, 243),
                              borderRadius: BorderRadius.circular(150)),
                          child: const Loading()),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Spacer(),
            ],
          )
        ]),
      ),
    );
  }
}
