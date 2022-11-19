import 'package:flutter/material.dart';
import 'my_icon.dart';
import 'package:sizer/sizer.dart';

class MyIconButton extends StatelessWidget {
  final SvgIcon svgIcon;
  final VoidCallback onPressed;
  final Color? iconColor;
  final double splashRadius;

  const MyIconButton({
    Key? key,
    required this.onPressed,
    required this.svgIcon,
    this.iconColor,
    this.splashRadius : 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = iconColor == null ? Theme.of(context).accentColor: iconColor;
    return IconButton(
      onPressed: onPressed,
      icon: MyIcon(
        svgIcon: svgIcon,
        color: color!,
      ),
      splashRadius: splashRadius.sp,
    );
  }
}
