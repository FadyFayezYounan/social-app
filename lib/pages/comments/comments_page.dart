import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/common_widgets/my_icon_button.dart';
import 'package:social_app/common_widgets/my_sized_box.dart';
import 'package:social_app/common_widgets/my_text_filed.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/pages/comments/emoji_button.dart';
import 'package:social_app/providers/comment_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:demoji/demoji.dart';
import 'package:social_app/services/convert_from_snap_shot_to_modal.dart';

import 'comment_widget.dart';

class CommentsPage extends StatefulWidget {
  static const routeName = '/comments-page';

  const CommentsPage({Key? key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appTextTheme = Theme.of(context).textTheme;
    var passedData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //int moreThanOneComment = 0;
    void savePostOnPressed(CommentProvider commentProvider) {
      if (controller.text.trim().isNotEmpty) {
        commentProvider.saveCommentContentToFireStore(
          uId: passedData['uId']!,
          postId: passedData['postId']!,
          userName: passedData['userName']!,
          userImage: passedData['userImage']!,
          createdAt: Timestamp.now(),
          commentContent: controller.text,
        );
        // commentProvider.increaseNumberOfComments(
        //   increasedBy: 1,
        //   postId: passedData['postId']!,
        //   currentCommentsNumber:
        //       int.parse(passedData['currentCommentsNumber']!),
        // );
        // moreThanOneComment++;
        controller.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                MyIcon(
                  svgIcon: SvgIcon.InfoSquare,
                  color: Colors.white,
                ),
                const Text(
                  '  Comment must not be empty',
                  maxLines: 1,
                ),
              ],
            ),
            backgroundColor: Color(0xFFE57373),
          ),
        );
      }
    }

    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) => WillPopScope(
        onWillPop: () async {
          // if (moreThanOneComment > 1) {
          //   commentProvider.increaseNumberOfComments(
          //     increasedBy: moreThanOneComment,
          //     postId: passedData['postId']!,
          //     currentCommentsNumber:
          //         int.parse(passedData['currentCommentsNumber']!),
          //   );
          // }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: MyIconButton(
              svgIcon: SvgIcon.ArrowLeftCircle,
              onPressed: () {
                // if (moreThanOneComment > 1) {
                //   commentProvider.increaseNumberOfComments(
                //     increasedBy: moreThanOneComment,
                //     postId: passedData['postId']!,
                //     currentCommentsNumber:
                //         int.parse(passedData['currentCommentsNumber']!),
                //   );
                // }
                Navigator.pop(context);
              },
            ),
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                Text(
                  '${passedData['postCreatorName']!}',
                  style: appTextTheme.bodyText2,
                ),
                Text(
                  'comments',
                  style: appTextTheme.headline6,
                ),
              ],
            ),
            actions: [
              MyIconButton(
                svgIcon: SvgIcon.TickSquare,
                iconColor: Theme.of(context).accentColor,
                onPressed: () => savePostOnPressed(commentProvider),
              ),
            ],
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  MyHeightSizedBox(),
                  ///comments
                  Expanded(
                    child: StreamBuilder(
                      stream: commentProvider.listenToPostComments(postId: passedData['postId']),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> commentSnapshot) {
                        if (commentSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final allComments = commentSnapshot.data.docs;
                        if (allComments.length == 0) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No comments yet!!'),
                              MyHeightSizedBox(),
                              MyIcon(
                                svgIcon: SvgIcon.Comment,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.5),
                                size: 16.w,
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: allComments.length,
                          itemBuilder: (BuildContext context, int index) =>
                              CommentWidget(
                           commentModel: CommentModel.fromJson(allComments[index]),//ConvertFromSnapshotToModal.commentModel(allComments[index]),
                          ),
                          reverse: true,
                        );
                      },
                    ),
                  ),
                  buildUserInput(passedData),
                ],
              ),
              commentProvider.loading == true
                  ? LinearProgressIndicator(
                      minHeight: 1.6,
                    )
                  : Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildUserInput(Map<String, dynamic> passedData) {
    return Container(
      margin: const EdgeInsets.all(KAppPadding),
      padding: const EdgeInsets.all(KAppPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 4.0,
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        children: [
          buildEmojiButtons(),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(passedData['userImage']!),
              ),
              SizedBox(
                width: KAppPadding / 2,
              ),
              Expanded(
                child: MyTextFiled(
                  controller: controller,
                  hintText: 'Leave a comment...',
                  borderRadius: 48.0,
                  vContentPadding: 0.0,
                  hPadding: 0.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildEmojiButtons() {
    return Wrap(
      children: [
        EmojiButton(controller: controller, emojiName: Demoji.heart_eyes),
        EmojiButton(controller: controller, emojiName: Demoji.sweat_smile),
        EmojiButton(controller: controller, emojiName: Demoji.joy),
        EmojiButton(controller: controller, emojiName: Demoji.heart),
        EmojiButton(controller: controller, emojiName: Demoji.ok_hand),
        EmojiButton(controller: controller, emojiName: Demoji.plus_one),
        EmojiButton(
            controller: controller,
            emojiName: Demoji.stuck_out_tongue_winking_eye),
        EmojiButton(controller: controller, emojiName: Demoji.upside_down_face),
      ],
    );
  }
}


//import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:social_app/common_widgets/my_icon.dart';
// import 'package:social_app/common_widgets/my_icon_button.dart';
// import 'package:social_app/common_widgets/my_sized_box.dart';
// import 'package:social_app/common_widgets/my_text_filed.dart';
// import 'package:social_app/constants.dart';
// import 'package:social_app/pages/comments/emoji_button.dart';
// import 'package:social_app/providers/comment_provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:demoji/demoji.dart';
//
// import 'comment_widget.dart';
//
// class CommentsPage extends StatefulWidget {
//   static const routeName = '/comments-page';
//
//   const CommentsPage({Key? key}) : super(key: key);
//
//   @override
//   _CommentsPageState createState() => _CommentsPageState();
// }
//
// class _CommentsPageState extends State<CommentsPage> {
//   late TextEditingController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var appTextTheme = Theme.of(context).textTheme;
//     var passedData =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     //int moreThanOneComment = 0;
//     void savePostOnPressed(CommentProvider commentProvider) {
//       if (controller.text.trim().isNotEmpty) {
//         commentProvider.saveCommentContentToFireStore(
//           uId: passedData['uId']!,
//           postId: passedData['postId']!,
//           userName: passedData['userName']!,
//           userImage: passedData['userImage']!,
//           createdAt: Timestamp.now(),
//           commentContent: controller.text,
//         );
//         // commentProvider.increaseNumberOfComments(
//         //   increasedBy: 1,
//         //   postId: passedData['postId']!,
//         //   currentCommentsNumber:
//         //       int.parse(passedData['currentCommentsNumber']!),
//         // );
//         // moreThanOneComment++;
//         controller.clear();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Row(
//               children: [
//                 MyIcon(
//                   svgIcon: SvgIcon.InfoSquare,
//                   color: Colors.white,
//                 ),
//                 const Text(
//                   '  Comment must not be empty',
//                   maxLines: 1,
//                 ),
//               ],
//             ),
//             backgroundColor: Color(0xFFE57373),
//           ),
//         );
//       }
//     }
//
//     return Consumer<CommentProvider>(
//       builder: (context, commentProvider, child) => WillPopScope(
//         onWillPop: () async {
//           // if (moreThanOneComment > 1) {
//           //   commentProvider.increaseNumberOfComments(
//           //     increasedBy: moreThanOneComment,
//           //     postId: passedData['postId']!,
//           //     currentCommentsNumber:
//           //         int.parse(passedData['currentCommentsNumber']!),
//           //   );
//           // }
//           return true;
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             leading: MyIconButton(
//               svgIcon: SvgIcon.ArrowLeftCircle,
//               onPressed: () {
//                 // if (moreThanOneComment > 1) {
//                 //   commentProvider.increaseNumberOfComments(
//                 //     increasedBy: moreThanOneComment,
//                 //     postId: passedData['postId']!,
//                 //     currentCommentsNumber:
//                 //         int.parse(passedData['currentCommentsNumber']!),
//                 //   );
//                 // }
//                 Navigator.pop(context);
//               },
//             ),
//             automaticallyImplyLeading: false,
//             title: Column(
//               children: [
//                 Text(
//                   '${passedData['postCreatorName']!}',
//                   style: appTextTheme.bodyText2,
//                 ),
//                 Text(
//                   'comments',
//                   style: appTextTheme.headline6,
//                 ),
//               ],
//             ),
//             actions: [
//               MyIconButton(
//                 svgIcon: SvgIcon.TickSquare,
//                 iconColor: Theme.of(context).accentColor,
//                 onPressed: () => savePostOnPressed(commentProvider),
//               ),
//             ],
//           ),
//           body: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               Column(
//                 children: [
//                   MyHeightSizedBox(),
//                   ///comments
//                   Expanded(
//                     child: StreamBuilder(
//                       stream: FirebaseFirestore.instance
//                           .collection('all_posts')
//                           .doc(passedData['postId'])
//                           .collection('post_comments')
//                           .orderBy('createdAt')
//                           .snapshots(),
//                       builder: (BuildContext context,
//                           AsyncSnapshot<dynamic> commentSnapshot) {
//                         if (commentSnapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Center(child: CircularProgressIndicator());
//                         }
//                         final allComments = commentSnapshot.data.docs;
//                         if (allComments.length == 0) {
//                           return Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('No comments yet!!'),
//                               MyHeightSizedBox(),
//                               MyIcon(
//                                 svgIcon: SvgIcon.Comment,
//                                 color: Theme.of(context)
//                                     .accentColor
//                                     .withOpacity(0.5),
//                                 size: 16.w,
//                               ),
//                             ],
//                           );
//                         }
//                         return ListView.builder(
//                           physics: BouncingScrollPhysics(),
//                           itemCount: allComments.length,
//                           itemBuilder: (BuildContext context, int index) =>
//                               CommentWidget(
//                             userImage: allComments[index]['userImage'],
//                             userName: allComments[index]['userName'],
//                             commentContent: allComments[index]
//                                 ['commentContent'],
//                             createdAt: allComments[index]['createdAt'],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   buildUserInput(passedData),
//                 ],
//               ),
//               commentProvider.loading == true
//                   ? LinearProgressIndicator(
//                       minHeight: 1.6,
//                     )
//                   : Divider(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Container buildUserInput(Map<String, dynamic> passedData) {
//     return Container(
//       margin: const EdgeInsets.all(KAppPadding),
//       padding: const EdgeInsets.all(KAppPadding),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             spreadRadius: 4.0,
//             blurRadius: 16,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           buildEmojiButtons(),
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(passedData['userImage']!),
//               ),
//               SizedBox(
//                 width: KAppPadding / 2,
//               ),
//               Expanded(
//                 child: MyTextFiled(
//                   controller: controller,
//                   hintText: 'Leave a comment...',
//                   borderRadius: 48.0,
//                   vContentPadding: 0.0,
//                   hPadding: 0.0,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildEmojiButtons() {
//     return Wrap(
//       children: [
//         EmojiButton(controller: controller, emojiName: Demoji.heart_eyes),
//         EmojiButton(controller: controller, emojiName: Demoji.sweat_smile),
//         EmojiButton(controller: controller, emojiName: Demoji.joy),
//         EmojiButton(controller: controller, emojiName: Demoji.heart),
//         EmojiButton(controller: controller, emojiName: Demoji.ok_hand),
//         EmojiButton(controller: controller, emojiName: Demoji.plus_one),
//         EmojiButton(
//             controller: controller,
//             emojiName: Demoji.stuck_out_tongue_winking_eye),
//         EmojiButton(controller: controller, emojiName: Demoji.upside_down_face),
//       ],
//     );
//   }
// }