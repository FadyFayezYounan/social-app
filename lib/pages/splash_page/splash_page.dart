import 'package:flutter/material.dart';
import 'package:social_app/common_widgets/show_lottie_image.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ShowLottieImage(lottieName: LottieName.splash,),
      ),
    );
  }
}
