import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/common_widgets/show_lottie_image.dart';


enum AppDialogType{
  warning,
  error,
}
Future<bool> appDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  required AppDialogType appDialogType,
}) async{
  LottieName lottieName = appDialogType == AppDialogType.warning ? LottieName.warning_white : LottieName.error;
  return await showDialog(context: context, builder: (context) => AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    contentPadding: EdgeInsets.zero,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: SizerUtil.orientation == Orientation.portrait ? 24.h: 26.w,
          decoration: BoxDecoration(
            color: Color(0xFFE57373),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: ShowLottieImage(lottieName: lottieName,repeat: false,),
              ),
              Padding(
                padding: EdgeInsets.all(SizerUtil.orientation == Orientation.portrait ? 4.w: 1.h),
                child: Text(
                  '$title',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(SizerUtil.orientation == Orientation.portrait ? 4.w: 1.h),
          child: Text(
            '$subTitle',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: 14.sp,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom:SizerUtil.orientation == Orientation.portrait ? 4.w: 1.h),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Ok',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFE57373),
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 1.6.h,
              ),
            ),
          ),
        ),
      ],
    ),
  ));
}
