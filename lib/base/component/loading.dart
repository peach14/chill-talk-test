import 'package:flutter/material.dart';

import '../utils/constants/asset_phat.dart';

class Loading extends StatefulWidget {
  final double height;
  final Color color;
  final double loadingSize;

  const Loading(
      {Key? key,
      this.height = 110,
      this.color = Colors.white,
      this.loadingSize = 30})
      : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration:
          const Duration(milliseconds: 2500), // Adjust the duration as needed
      vsync: this,
    );

    // Define the tween for opacity animation
    opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    // Set up the animation to loop
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    // Start the animation
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Opacity(
          opacity: opacityAnimation.value, // Use the animated opacity value
          child: Image.asset(scale: 1, ImagePhat.logoChillTalk),
        );
      },
    );
  }
}
