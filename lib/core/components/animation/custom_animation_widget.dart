import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomAnimationWidget extends StatelessWidget {
  final String animationType;
  final double? width;
  final double? height;

  const CustomAnimationWidget({
    super.key,
    required this.animationType,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      height: height ?? 200,
      child: Center(
        child: Lottie.asset(
          animationType,
          width: width,
          height: height,
          fit: BoxFit.contain,
          repeat: true,
          animate: true,
        ),
      ),
    );
  }
}
