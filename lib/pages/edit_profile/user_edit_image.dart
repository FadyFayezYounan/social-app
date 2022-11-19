import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserEditImage extends StatelessWidget {
  final VoidCallback onButtonPressed;
  final String imagePath;

  const UserEditImage({
    Key? key,
    required this.imagePath,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = imagePath.contains('https://')?NetworkImage(imagePath):FileImage(File(imagePath));
    return Container(
      alignment: Alignment.center,
      width: 100.w,
      height: 20.h,
      //color: Colors.grey,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CircleAvatar(
            radius: 14.w,
            backgroundImage: image as ImageProvider,
          ),
          buildEditButton(onButtonPressed,context),
        ],
      ),
    );
  }

  // Widget buildEditButton() {
  //   return InkWell(
  //     //borderRadius: BorderRadius.circular(48),
  //     customBorder: StadiumBorder(),
  //     radius: 30,
  //     splashColor: Colors.grey,
  //     onTap: (){},
  //     child: CircleAvatar(
  //           radius: 5.6.w,
  //           backgroundColor: Colors.white,
  //           child: CircleAvatar(
  //             backgroundColor: Colors.deepPurple,
  //             child: Icon(
  //               Icons.edit,
  //               color: Colors.white,
  //               size: 16.sp,
  //             ),
  //             radius: 5.w,
  //           ),
  //         ),
  //   );
  // }

  Widget buildEditButton(VoidCallback onButtonPressed , context) {
    ///White CircleAvatar
    return CircleAvatar(
      radius: 5.6.w,
      backgroundColor: Colors.white,
      ///Colored CircleAvatar
      child: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onButtonPressed,
            customBorder: StadiumBorder(),
            child: Padding(
              padding: EdgeInsets.all(2.4.w),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
        ),
        radius: 5.w,
      ),
    );
  }
}
//Material(
//           color: Colors.transparent,
//           child: CircleAvatar(
//                 radius: 5.6.w,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.deepPurple,
//                   child: Icon(
//                     Icons.edit,
//                     color: Colors.white,
//                     size: 16.sp,
//                   ),
//                   radius: 5.w,
//                 ),
//               ),
//         )
