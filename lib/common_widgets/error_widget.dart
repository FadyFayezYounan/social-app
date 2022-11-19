import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/common_widgets/show_lottie_image.dart';

class ErrorOccurredWidget extends StatelessWidget {
  const ErrorOccurredWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ShowLottieImage(
            lottieName: LottieName.error,
            repeat: false,
            size: 25.w,
          ),
          Text('An Error Occurred',textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
