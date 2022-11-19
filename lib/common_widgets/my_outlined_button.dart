import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double paddingHeight;
  final double buttonHeight;
  final double fontSize;

  const MyOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.paddingHeight: 0.0,
    this.buttonHeight : 8,
    this.fontSize : 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight.h,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(text,style: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w500,
        ),),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(paddingHeight.h),
          shape: StadiumBorder(),
          side: BorderSide(
            color: Theme.of(context).accentColor.withOpacity(0.5),
            width: 0.6,
          ),
        ),
      ),
    );
  }
}
