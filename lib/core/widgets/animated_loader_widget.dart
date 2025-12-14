import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedLoaderWidget extends StatelessWidget {
  const AnimatedLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 120,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Lottie.asset('assets/lottie/loader.json'),
    );
  }
}
