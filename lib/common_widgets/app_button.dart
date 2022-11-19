import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/constants.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;
  final double borderRadius;
  final double? buttonWidth;
  final double? buttonHeight;
  final double vPadding;
  final double hPadding;
  final bool loading;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.fontSize,
    this.borderRadius: KAppPadding / 2,
    this.buttonWidth,
    this.buttonHeight : 8,
    this.vPadding: 1.6,
    this.hPadding: 0,
    this.loading: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 750),
      width:loading == true ? 16.w:33.w,
      height: buttonHeight == null ? 8.h :buttonHeight!.h,
      child: RawMaterialButton(
        onPressed: onPressed,
        child: loading == true
            ? SizedBox(
                width: 8.w,
                height: 8.w,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor == null ? Colors.white : textColor,
                  fontSize: fontSize == null ? 14.sp : fontSize,
                ),
              ),
        fillColor: buttonColor == null ? appTheme.primaryColor : buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        constraints: BoxConstraints.tightFor(
          width: buttonWidth,
          height: buttonHeight,
        ),
        padding:
            EdgeInsets.symmetric(horizontal: hPadding.w, vertical: vPadding.h),
        elevation: 0.0,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:social_app/constants.dart';
//
// class AppButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final Color? buttonColor;
//   final Color? textColor;
//   final double? fontSize;
//   final double borderRadius;
//   final double? buttonWidth;
//   final double? buttonHeight;
//   final double vPadding;
//   final double hPadding;
//
//   const AppButton({
//     Key? key,
//     required this.text,
//     required this.onPressed,
//     this.buttonColor,
//     this.textColor,
//     this.fontSize,
//     this.borderRadius : KAppPadding/2,
//     this.buttonWidth,
//     this.buttonHeight,
//     this.vPadding : 3,
//     this.hPadding : 3,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var appTheme = Theme.of(context);
//     return RawMaterialButton(
//       onPressed: onPressed,
//       child: Text(
//         text,
//         style: TextStyle(
//           color: textColor == null ? Colors.white : textColor,
//           fontSize: fontSize == null ? 16.sp : fontSize,
//         ),
//       ),
//       fillColor: buttonColor == null ? appTheme.primaryColor : buttonColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(borderRadius),
//       ),
//       constraints: BoxConstraints.tightFor(
//         width: buttonWidth,
//         height: buttonHeight,
//       ),
//       padding: EdgeInsets.symmetric(horizontal: hPadding.w,vertical: vPadding.h),
//       elevation: 0.0,
//     );
//   }
// }
