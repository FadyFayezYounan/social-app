import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/common_widgets/my_icon_button.dart';


import 'my_icon.dart';

AppBar buildAppBar({required BuildContext context, required String title}) {
  return AppBar(
    leading:MyIconButton(
      svgIcon: SvgIcon.Category,
      onPressed: (){
        //Navigator.pushNamed(context, SettingsPage.routeName);
      },
    ),
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
      ),
    ),
  );
}
