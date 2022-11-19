import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:sizer/sizer.dart';

void buildCustomDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
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
                      child: Lottie.asset(
                        'assets/lottie/error.json',
                        fit: BoxFit.contain,
                        repeat: false,
                      ),
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
                    Navigator.pop(ctx);
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
        );
      });
}
