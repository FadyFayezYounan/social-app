import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double paddingHeight;

  const MyFilledButton({
    Key? key,
    required this.onPressed,
    this.paddingHeight : 3.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Text(
        'photo',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          //fontWeight: FontWeight.w500,
        ),
      ),
      elevation: 0.0,
      fillColor: Theme.of(context).primaryColor,
      shape: StadiumBorder(),
      padding: EdgeInsets.all(paddingHeight.h),
    );
  }
}
