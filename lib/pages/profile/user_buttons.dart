import 'package:flutter/material.dart';
import 'package:social_app/common_widgets/app_button.dart';

import 'package:social_app/common_widgets/my_outlined_button.dart';
import 'package:sizer/sizer.dart';

class UserButtons extends StatelessWidget {
  final VoidCallback onFirstButtonPressed;
  final VoidCallback onSecondButtonPressed;
  final String firstButtonText;
  final String secondButtonText;

  const UserButtons({
    Key? key,
    required this.onFirstButtonPressed,
    required this.onSecondButtonPressed,
    required this.firstButtonText,
    required this.secondButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: AppButton(
              onPressed: onFirstButtonPressed,
              text: firstButtonText,
              borderRadius: 48.0,
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            child: MyOutlinedButton(
              onPressed: onSecondButtonPressed,
              text: secondButtonText,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:social_app/common_widgets/my_filled_button.dart';
// import 'package:social_app/common_widgets/my_outlined_button.dart';
// import 'package:sizer/sizer.dart';
// import 'package:social_app/pages/edit_profile/edit_profile_page.dart';
//
// class UserButtons extends StatelessWidget {
//   const UserButtons({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             child: MyFilledButton(
//               onPressed: () {
//
//               },
//             ),
//           ),
//           SizedBox(
//             width: 4.w,
//           ),
//           Expanded(
//             child: MyOutlinedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, EditProfilePage.routeName);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
