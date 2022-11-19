import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum LottieName {
  search,
  error,
  manChatting,
  loader,
  love,
  splash,
  warning_white,
}

class ShowLottieImage extends StatelessWidget {
  final double size;
  final LottieName lottieName;
  final bool repeat;

  const ShowLottieImage({
    Key? key,
    this.size: 52,
    required this.lottieName,
    this.repeat = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final String iconName;
    switch (lottieName) {
      case LottieName.search:
        iconName = 'search';
        break;
      case LottieName.error:
        iconName = 'error-animation';
        break;
      case LottieName.manChatting:
        iconName = 'man-chatting-on-his-mobile-phone';
        break;
      case LottieName.loader:
        iconName = 'my_loader';
        break;
      case LottieName.love:
        iconName = 'love';
        break;
      case LottieName.splash:
        iconName = 'splash';
        break;
      case LottieName.warning_white:
        iconName = 'warning_white';
        break;
    }
    return Container(
      width: size * 2,
      height: size * 2,
      child: Lottie.asset(
        'assets/lottie/$iconName.json',
        fit: BoxFit.contain,
        repeat: repeat,
      ),
    );
  }
}
