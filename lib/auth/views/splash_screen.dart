import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../base/component/loading.dart';
import '../../base/config/routing/route_path.dart';
import '../../base/service/local_storage/secure_storage_service.dart';
import '../../base/utils/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final getToken = await SecureStorage.instance.getToken();
      await Future.delayed(const Duration(seconds: 2));
      int myInt = int.parse(getToken ?? '7');
      if (mounted) {
        if (myInt == keySuccessToken) {
          context.go(kNevMain);
        } else {
          context.go(kNevLogin);
        }
      }
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
