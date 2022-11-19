import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = imagePath.contains('https://')?NetworkImage(imagePath):FileImage(File(imagePath));
    return Container(
      width: 100.w,
      height: 20.h,
      //color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildFollowingOrFollowers(context:context,number: 321, text: 'followers'),
          CircleAvatar(
            radius: 14.w,
            backgroundImage: image as ImageProvider,
          ),
          buildFollowingOrFollowers(context:context,number: 125, text: 'following'),
        ],
      ),
    );
  }

  Column buildFollowingOrFollowers(
      {required context,required int number, required String text}) {
    final appTextTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$number',
          style: appTextTheme.headline5,
        ),
        Text(
          '$text',
          style: appTextTheme.bodyText2,
        ),
      ],
    );
  }
}
