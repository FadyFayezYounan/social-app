import 'package:flutter/material.dart';
import 'package:social_app/common_widgets/my_loader.dart';
import 'package:social_app/constants.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      contentPadding: EdgeInsets.only(bottom: KAppPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      content: Stack(
        //mainAxisSize: MainAxisSize.min,
        alignment: Alignment.bottomCenter,
        children: [
          Text('Loading..'),
          MyLoader(),
        ],
      ),
    ),

  );
}
