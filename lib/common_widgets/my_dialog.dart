import 'package:flutter/material.dart';

import 'my_icon.dart';
import 'package:sizer/sizer.dart';

void buildMyDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
}) {
  //SizerUtil.orientation == SizerUtil.orientat

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
                width: 100.w,
                height: SizerUtil.orientation == Orientation.portrait ? 26.h: 26.w,
                decoration: BoxDecoration(
                  color: Color(0xFFE57373),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyIcon(
                      svgIcon: SvgIcon.InfoSquare,
                      color: Colors.white,
                      size: 56.sp,
                    ),
                    Text(
                      '$title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
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
                padding: EdgeInsets.all(SizerUtil.orientation == Orientation.portrait ? 4.w: 1.h),
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
