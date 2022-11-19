
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/common_widgets/my_icon.dart';

import 'package:social_app/constants.dart';
import 'package:social_app/models/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel commentModel;

  const CommentWidget({
    Key? key,
    required this.commentModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('${commentModel.userImage}'),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${commentModel.userName}',
            style: appTheme.textTheme.subtitle1!.copyWith(
              fontSize: 14.sp,
            ),
          ),
          ExpandableText(
            '${commentModel.commentContent}',
            style: appTheme.textTheme.bodyText2,
            expandText: 'show more',
            collapseText: 'show less',
            linkColor: Colors.blue,
            maxLines: 5,
            textAlign: TextAlign.start,
            animation: true,
            animationDuration: Duration(seconds: 1),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkResponse(
            radius: 16.sp,
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: KAppPadding / 2),
              child: MyIcon(
                svgIcon: SvgIcon.Heart2,
                color: appTheme.accentColor.withOpacity(0.5),
              ),
            ),
          ),
          Text(
            '${DateFormat('MM-dd, hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(commentModel.createdAt!.microsecondsSinceEpoch))}',
            style: appTheme.textTheme.bodyText2!.copyWith(
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

//import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expandable_text/expandable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';
// import 'package:social_app/common_widgets/my_icon.dart';
// import 'package:social_app/common_widgets/my_icon_button.dart';
// import 'package:social_app/constants.dart';
//
// class CommentWidget extends StatelessWidget {
//   final String userName;
//   final String userImage;
//   final String commentContent;
//   final Timestamp createdAt;
//
//   const CommentWidget({
//     Key? key,
//     required this.userName,
//     required this.commentContent,
//     required this.createdAt,
//     required this.userImage,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var appTheme = Theme.of(context);
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(userImage),
//       ),
//       title: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             userName,
//             style: appTheme.textTheme.subtitle1!.copyWith(
//               fontSize: 14.sp,
//             ),
//           ),
//           ExpandableText(
//             commentContent,
//             style: appTheme.textTheme.bodyText2,
//             expandText: 'show more',
//             collapseText: 'show less',
//             linkColor: Colors.blue,
//             maxLines: 5,
//             textAlign: TextAlign.start,
//             animation: true,
//             animationDuration: Duration(seconds: 1),
//           ),
//         ],
//       ),
//       subtitle: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           InkResponse(
//             radius: 16.sp,
//             onTap: () {},
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: KAppPadding / 2),
//               child: MyIcon(
//                 svgIcon: SvgIcon.Heart2,
//                 color: appTheme.accentColor.withOpacity(0.5),
//               ),
//             ),
//           ),
//           Text(
//             '${DateFormat('MM-dd, hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(createdAt.microsecondsSinceEpoch))}',
//             style: appTheme.textTheme.bodyText2!.copyWith(
//               fontSize: 10.sp,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
