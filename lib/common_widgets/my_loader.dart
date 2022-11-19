import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLoader extends StatelessWidget {
  final double size;

  const MyLoader({
    Key? key,
    this.size: 52,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 2,
      height: size * 2,
      //color: Colors.indigo,
      child: Lottie.asset(
        'assets/lottie/my_loader.json',
        fit: BoxFit.contain
      ),
    );
  }
}
