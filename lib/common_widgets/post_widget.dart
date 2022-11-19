import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/custom_dialog.dart';
import 'package:social_app/common_widgets/my_icon_button.dart';
import 'package:social_app/common_widgets/my_modal_bottom_sheet.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/chat/chat_between_page.dart';
import 'package:social_app/pages/comments/comments_page.dart';
import 'package:social_app/pages/user_profile_info/user_info_page.dart';
import 'package:social_app/providers/post_provider.dart';
import 'package:social_app/providers/user_provider.dart';
import 'my_icon.dart';
import 'package:sizer/sizer.dart';
import 'my_sized_box.dart';

class PostWidget extends StatefulWidget {
  final PostModel postModel;
  final String postId;

  const PostWidget({
    Key? key,
    required this.postModel,
    required this.postId,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  //bool isLiked = false;
  bool _isLiked = false;

  //var currentUser = UserPreferences.getUser(userKey: KUserKey);

  bool isHeartAnimating = false;

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    // bool changeHeart = (widget.postLikes[currentUser.uId] == true);
    var numberOfLikes = 0;
    widget.postModel.postLikes!.forEach((key, value) {
      if (value == true) {
        numberOfLikes++;
      }
    });
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        var currentUser = userProvider.getCurrentUserData;
        bool changeHeart =
            (widget.postModel.postLikes![currentUser.uId] == true);
        return Consumer<PostProvider>(
          builder: (context, postProvider, child) => Container(
            margin: EdgeInsets.symmetric(vertical: KAppPadding / 2),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ///User Info
                buildUserInfo(appTheme, postProvider, currentUser),

                ///Post Content
                buildPostText(appTheme),
                SizedBox(height: KAppPadding / 2),

                ///Image
                if (widget.postModel.postImage != '')
                  buildPostImage(changeHeart, postProvider),

                /// User Interaction
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _isLiked =
                              widget.postModel.postLikes![currentUser.uId] ??
                                  false;
                          if (_isLiked == true) {
                            try {
                              postProvider.likePost(
                                postId: widget.postId,
                                value: false,
                                postCreatorId: widget.postModel.uId!,
                              );
                            } catch (error) {
                              buildCustomDialog(
                                context: context,
                                title: 'An Error Occurred',
                                subTitle: error.toString(),
                              );
                            }
                            setState(() {
                              changeHeart = false;
                            });
                          } else if (_isLiked == false) {
                            try {
                              postProvider.likePost(
                                postId: widget.postId,
                                value: true,
                                postCreatorId: widget.postModel.uId!,
                              );
                            } catch (error) {
                              buildCustomDialog(
                                context: context,
                                title: 'An Error Occurred',
                                subTitle: error.toString(),
                              );
                            }
                            setState(() {
                              changeHeart = true;
                            });
                          }
                        },
                        style: TextButton.styleFrom(
                          //backgroundColor: Colors.redAccent.withOpacity(0.08),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          primary: Colors.redAccent,
                        ),
                        icon: MyIcon(
                          svgIcon: changeHeart == true
                              ? SvgIcon.HeartFilled
                              : SvgIcon.Heart2,
                          color: changeHeart == true
                              ? Colors.redAccent
                              : appTheme.accentColor,
                        ),
                        label: Text(
                          '$numberOfLikes',
                          style: appTheme.textTheme.subtitle1!.copyWith(
                            color: appTheme.accentColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            CommentsPage.routeName,
                            arguments: {
                              'uId': currentUser.uId,
                              'postId': widget.postId,
                              'currentCommentsNumber':
                                  'widget.numberOfComments.toString()',
                              'userName': currentUser.name,
                              'userImage': currentUser.imageUrl,
                              'postCreatorName': widget.postModel.userName,
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          //backgroundColor: Colors.redAccent.withOpacity(0.08),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          primary: Colors.teal,
                        ),
                        icon: MyIcon(
                          svgIcon: SvgIcon.Comment,
                          color: appTheme.accentColor,
                        ),
                        label: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('all_posts')
                              .doc(widget.postId)
                              .collection('post_comments')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> commentsSnapshot) {
                            if (commentsSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                '',
                                style: appTheme.textTheme.subtitle1!.copyWith(
                                  color: appTheme.accentColor.withOpacity(0.7),
                                ),
                              );
                            }
                            final allComments = commentsSnapshot.data.docs;
                            return Text(
                              '${allComments.length}',
                              style: appTheme.textTheme.subtitle1!.copyWith(
                                color: appTheme.accentColor.withOpacity(0.7),
                              ),
                            );
                          },
                        ),
                      ),
                      Spacer(),
                      MyIconButton(
                        svgIcon: SvgIcon.Bookmark,
                        onPressed: () {},
                        splashRadius: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile buildUserInfo(
      ThemeData appTheme, PostProvider postProvider, currentUser) {
    return ListTile(
      contentPadding:
          EdgeInsets.only(left: KAppPadding, right: KAppPadding / 2),
      leading: SizedBox(
        width: 14.w,
        height: 14.w,
        child: InkResponse(
          onTap: () {
            Navigator.pushNamed(
              context,
              UserProfileInfoPage.routeName,
              arguments: widget.postModel.uId,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(48.0),
            child: CachedNetworkImage(
              imageUrl: '${widget.postModel.userImage}',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                child: MyIcon(
                  svgIcon: SvgIcon.Profile,
                  color: Theme.of(context).accentColor.withOpacity(0.5),
                  size: 12.sp,
                ),
              ),
              errorWidget: (context, url, error) => MyIcon(
                svgIcon: SvgIcon.InfoSquare,
                color: Colors.redAccent,
                size: 12.sp,
              ),
            ),
          ),
        ),
      ),
      title: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            UserProfileInfoPage.routeName,
            arguments: widget.postModel.uId,
          );
        },
        child: Text(
          widget.postModel.userName!, //'${postModel.userName}',//'fady fayez',
          style: appTheme.textTheme.subtitle1!.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ),
      subtitle: Text(
        convertFromTimestampToTime(
            timestamp: widget.postModel.createdAt!,
            timeFormat: TimeFormat.monthDaysHoursMinutes),
        //'${DateTime.now().toString().substring(0, 10)}',
        style: appTheme.textTheme.bodyText2!.copyWith(
          fontSize: 10.sp,
        ),
      ),
      trailing: MyIconButton(
        svgIcon: SvgIcon.MoreSquare,
        onPressed: () {
          myModalBottomSheet(
            context: context,
            isCreator: (currentUser.uId == widget.postModel.uId),
            userName: widget.postModel.userName!,
            deleteButtonPressed: () {
              postProvider.deletePost(postId: widget.postId);
            },
            sendMessageButtonPressed: () {
              UserModel postCreator = UserModel(
                uId: widget.postModel.uId!,
                imageUrl: widget.postModel.userImage!,
                name: widget.postModel.userName!,
                email: '',
                imagePath: '',
                bio: '',
              );
              Navigator.pushNamed(context, ChatBetweenPage.routeName,
                  arguments: postCreator);
            },
          ); // end of myModalBottomSheet
        },
        splashRadius: 16.0,
      ),
    );
  }

  Container buildPostText(ThemeData appTheme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: KAppPadding),
      width: double.infinity,
      child: ExpandableText(
        widget.postModel.postContent!,
        //'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary,',
        expandText: 'show more',
        collapseText: 'show less',
        linkColor: Colors.blue,
        maxLines: 5,
        textAlign: TextAlign.start,
        style: appTheme.textTheme.bodyText1,
        animation: true,
        animationDuration: Duration(seconds: 1),
      ),
      //color: Colors.amber,
    );
  }

  Widget buildPostImage(bool changeHeart, PostProvider postProvider) {
    return GestureDetector(
      onDoubleTap: () {
        if (changeHeart == false) {
          //Provider.of<PostProvider>(context,listen: false).likePost(postId: widget.postId, value: true,);
          postProvider.likePost(
            postId: widget.postId,
            value: true,
            postCreatorId: widget.postModel.uId!,
          );
        }
        setState(() {
          isHeartAnimating = true;
          //isLiked = true;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: widget.postModel.postImage!,
            fit: BoxFit.contain,
            // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            placeholder: (context, url) => Container(
              // color: Colors.grey,
              padding: EdgeInsets.all(KAppPadding * 2),
              child: MyIcon(
                svgIcon: SvgIcon.Camera,
                color: Theme.of(context).accentColor.withOpacity(0.5),
                size: 48.0,
              ),
            ),
            errorWidget: (context, url, error) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyIcon(
                  svgIcon: SvgIcon.InfoSquare,
                  color: Colors.redAccent,
                  size: 48.0,
                ),
                MyHeightSizedBox(),
                Text(
                  'Something Went Wrong!!',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          Opacity(
            opacity: isHeartAnimating == true ? 1 : 0,
            child: HeartAnimationWidget(
              isAnimating: isHeartAnimating,
              onEnd: () {
                setState(() {
                  isHeartAnimating = false;
                });
              },
              duration: Duration(milliseconds: 750),
              child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 36.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeartAnimationWidget extends StatefulWidget {
  final bool isAnimating;
  final bool alwaysAnimating;
  final Widget child;
  final Duration duration;
  final VoidCallback? onEnd;

  const HeartAnimationWidget({
    Key? key,
    required this.isAnimating,
    this.alwaysAnimating: false,
    required this.child,
    this.duration: const Duration(milliseconds: 150),
    this.onEnd,
  }) : super(key: key);

  @override
  _HeartAnimationWidgetState createState() => _HeartAnimationWidgetState();
}

class _HeartAnimationWidgetState extends State<HeartAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    final halfDuration = widget.duration.inMilliseconds ~/ 2;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: halfDuration),
    );

    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant HeartAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      doAnimation();
    }
  }

  Future doAnimation() async {
    if (widget.isAnimating == true || widget.alwaysAnimating == true) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(Duration(milliseconds: 200));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expandable_text/expandable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:social_app/common_widgets/custom_likes_bottom_sheet.dart';
// import 'package:social_app/common_widgets/custom_dialog.dart';
// import 'package:social_app/common_widgets/my_icon_button.dart';
// import 'package:social_app/common_widgets/my_modal_bottom_sheet.dart';
// import 'package:social_app/constants.dart';
// import 'package:social_app/models/user_model.dart';
// import 'package:social_app/pages/chat/chat_between_page.dart';
// import 'package:social_app/pages/comments/comments_page.dart';
// import 'package:social_app/pages/user_profile_info/user_info_page.dart';
// import 'package:social_app/providers/post_provider.dart';
// import 'package:social_app/providers/user_provider.dart';
// import 'my_icon.dart';
// import 'package:sizer/sizer.dart';
// import 'my_sized_box.dart';
//
// class PostWidget extends StatefulWidget {
//   //final PostModel postModel;
//   final String uId;
//   final String userName;
//   final String userImage;
//   final Timestamp createdAt;
//   final String postContent;
//   final String postImage;
//   final String postId;
//   final Map postLikes;
//   final int numberOfComments;
//
//   const PostWidget({
//     Key? key,
//     //required this.postModel,
//     required this.uId,
//     required this.userName,
//     required this.userImage,
//     required this.createdAt,
//     required this.postContent,
//     required this.postImage,
//     required this.postId,
//     required this.postLikes,
//     this.numberOfComments: 100,
//   }) : super(key: key);
//
//   @override
//   _PostWidgetState createState() => _PostWidgetState();
// }
//
// class _PostWidgetState extends State<PostWidget> {
//   //bool isLiked = false;
//   bool _isLiked = false;
//
//   //var currentUser = UserPreferences.getUser(userKey: KUserKey);
//
//   bool isHeartAnimating = false;
//
//   @override
//   Widget build(BuildContext context) {
//     var appTheme = Theme.of(context);
//     // bool changeHeart = (widget.postLikes[currentUser.uId] == true);
//     var numberOfLikes = 0;
//     widget.postLikes.forEach((key, value) {
//       if (value == true) {
//         numberOfLikes++;
//       }
//     });
//     return Consumer<UserProvider>(
//       builder: (context, userProvider, child) {
//         var currentUser = userProvider.getCurrentUserData;
//         bool changeHeart = (widget.postLikes[currentUser.uId] == true);
//         return Consumer<PostProvider>(
//           builder: (context, postProvider, child) => Container(
//             margin: EdgeInsets.symmetric(vertical: KAppPadding / 2),
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
//                 ///User Info
//                 buildUserInfo(appTheme, postProvider, currentUser),
//
//                 ///Post Content
//                 buildPostText(appTheme),
//                 SizedBox(height: KAppPadding / 2),
//
//                 ///Image
//                 if (widget.postImage != '')
//                   buildPostImage(changeHeart, postProvider),
//
//                 /// User Interaction
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       TextButton.icon(
//                         onPressed: () {
//                           _isLiked = widget.postLikes[currentUser.uId] ?? false;
//                           if (_isLiked == true) {
//                             try {
//                               postProvider.likePost(
//                                 postCreatorId: widget.uId,
//                                 postId: widget.postId,
//                                 value: false,
//                               );
//                             } catch (error) {
//                               buildCustomDialog(
//                                 context: context,
//                                 title: 'An Error Occurred',
//                                 subTitle: error.toString(),
//                               );
//                             }
//                             setState(() {
//                               changeHeart = false;
//                             });
//                           } else if (_isLiked == false) {
//                             try {
//                               postProvider.likePost(
//                                 postCreatorId: widget.uId,
//                                 postId: widget.postId,
//                                 value: true,
//                               );
//                             } catch (error) {
//                               buildCustomDialog(
//                                 context: context,
//                                 title: 'An Error Occurred',
//                                 subTitle: error.toString(),
//                               );
//                             }
//                             setState(() {
//                               changeHeart = true;
//                             });
//                           }
//                         },
//                         style: TextButton.styleFrom(
//                           //backgroundColor: Colors.redAccent.withOpacity(0.08),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(32.0),
//                           ),
//                           primary: Colors.redAccent,
//                         ),
//                         icon: MyIcon(
//                           svgIcon: changeHeart == true
//                               ? SvgIcon.HeartFilled
//                               : SvgIcon.Heart2,
//                           color: changeHeart == true
//                               ? Colors.redAccent
//                               : appTheme.accentColor,
//                         ),
//                         label: Text(
//                           '$numberOfLikes',
//                           style: appTheme.textTheme.subtitle1!.copyWith(
//                             color: appTheme.accentColor.withOpacity(0.7),
//                           ),
//                         ),
//                         onLongPress: (){
//                           customLikesBottomSheet(context: context);
//                         },
//                       ),
//                       // TextButton.icon(
//                       //   onPressed: () {
//                       //     Navigator.pushNamed(
//                       //       context,
//                       //       CommentsPage.routeName,
//                       //       arguments: {
//                       //         'uId': currentUser.uId,
//                       //         'postId': widget.postId,
//                       //         'currentCommentsNumber':
//                       //             widget.numberOfComments.toString(),
//                       //         'userName': currentUser.name,
//                       //         'userImage': currentUser.imageUrl,
//                       //         'postCreatorName': widget.userName,
//                       //       },
//                       //     );
//                       //   },
//                       //   style: TextButton.styleFrom(
//                       //     //backgroundColor: Colors.redAccent.withOpacity(0.08),
//                       //     shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(32.0),
//                       //     ),
//                       //     primary: Colors.teal,
//                       //   ),
//                       //   icon: MyIcon(
//                       //     svgIcon: SvgIcon.Comment,
//                       //     color: appTheme.accentColor,
//                       //   ),
//                       //   label: StreamBuilder(
//                       //     stream: FirebaseFirestore.instance
//                       //         .collection('all_posts')
//                       //         .doc(widget.postId)
//                       //         .collection('post_comments')
//                       //         .snapshots(),
//                       //     builder: (BuildContext context,
//                       //         AsyncSnapshot<dynamic> commentsSnapshot) {
//                       //       if (commentsSnapshot.connectionState ==
//                       //           ConnectionState.waiting) {
//                       //         return Text(
//                       //           '',
//                       //           style: appTheme.textTheme.subtitle1!.copyWith(
//                       //             color: appTheme.accentColor.withOpacity(0.7),
//                       //           ),
//                       //         );
//                       //       }
//                       //       final allComments = commentsSnapshot.data.docs;
//                       //       return Text(
//                       //         '${allComments.length}',
//                       //         style: appTheme.textTheme.subtitle1!.copyWith(
//                       //           color: appTheme.accentColor.withOpacity(0.7),
//                       //         ),
//                       //       );
//                       //     },
//                       //   ),
//                       // ),
//                       TextButton.icon(
//                         onPressed: () {
//                           Navigator.pushNamed(
//                             context,
//                             CommentsPage.routeName,
//                             arguments: {
//                               'uId': currentUser.uId,
//                               'postId': widget.postId,
//                               'currentCommentsNumber':
//                                   widget.numberOfComments.toString(),
//                               'userName': currentUser.name,
//                               'userImage': currentUser.imageUrl,
//                               'postCreatorName': widget.userName,
//                             },
//                           );
//                         },
//                         style: TextButton.styleFrom(
//                           //backgroundColor: Colors.redAccent.withOpacity(0.08),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(32.0),
//                           ),
//                           primary: Colors.teal,
//                         ),
//                         icon: MyIcon(
//                           svgIcon: SvgIcon.Comment,
//                           color: appTheme.accentColor,
//                         ),
//                         label: StreamBuilder(
//                           stream: FirebaseFirestore.instance
//                               .collection('all_posts')
//                               .doc(widget.postId)
//                               .collection('post_comments')
//                               .snapshots(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<dynamic> commentsSnapshot) {
//                             if (commentsSnapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Text(
//                                 '',
//                                 style: appTheme.textTheme.subtitle1!.copyWith(
//                                   color: appTheme.accentColor.withOpacity(0.7),
//                                 ),
//                               );
//                             }
//                             final allComments = commentsSnapshot.data.docs;
//                             return Text(
//                               '${allComments.length}',
//                               style: appTheme.textTheme.subtitle1!.copyWith(
//                                 color: appTheme.accentColor.withOpacity(0.7),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Spacer(),
//                       MyIconButton(
//                         svgIcon: SvgIcon.Bookmark,
//                         onPressed: () {},
//                         splashRadius: 16,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   ListTile buildUserInfo(
//       ThemeData appTheme, PostProvider postProvider, currentUser) {
//     return ListTile(
//       contentPadding:
//           EdgeInsets.only(left: KAppPadding, right: KAppPadding / 2),
//       leading: SizedBox(
//         width: 14.w,
//         height: 14.w,
//         child: InkResponse(
//           onTap: () {
//             Navigator.pushNamed(context, UserProfileInfoPage.routeName,
//                 arguments: widget.uId);
//           },
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(48.0),
//             child: CachedNetworkImage(
//               imageUrl: widget.userImage,
//               fit: BoxFit.cover,
//               placeholder: (context, url) => Container(
//                 child: MyIcon(
//                   svgIcon: SvgIcon.Profile,
//                   color: Theme.of(context).accentColor.withOpacity(0.5),
//                   size: 12.sp,
//                 ),
//               ),
//               errorWidget: (context, url, error) => MyIcon(
//                 svgIcon: SvgIcon.InfoSquare,
//                 color: Colors.redAccent,
//                 size: 12.sp,
//               ),
//             ),
//           ),
//         ),
//       ),
//       title: InkWell(
//         onTap: () {
//           Navigator.pushNamed(context, UserProfileInfoPage.routeName,
//               arguments: widget.uId);
//         },
//         child: Text(
//           widget.userName, //'${postModel.userName}',//'fady fayez',
//           style: appTheme.textTheme.subtitle1!.copyWith(
//             fontSize: 14.sp,
//           ),
//         ),
//       ),
//       subtitle: Text(
//         convertFromTimestampToTime(
//             timestamp: widget.createdAt,
//             timeFormat: TimeFormat.monthDaysHoursMinutes),
//         //'${DateTime.now().toString().substring(0, 10)}',
//         style: appTheme.textTheme.bodyText2!.copyWith(
//           fontSize: 10.sp,
//         ),
//       ),
//       trailing: MyIconButton(
//         svgIcon: SvgIcon.MoreSquare,
//         onPressed: () {
//           myModalBottomSheet(
//             context: context,
//             isCreator: (currentUser.uId == widget.uId),
//             userName: widget.userName,
//             deleteButtonPressed: () {
//               postProvider.deletePost(postId: widget.postId);
//             },
//             sendMessageButtonPressed: () {
//               UserModel postCreator = UserModel(
//                 uId: widget.uId,
//                 imageUrl: widget.userImage,
//                 name: widget.userName,
//                 email: '',
//                 imagePath: '',
//                 bio: '',
//               );
//               Navigator.pushNamed(context, ChatBetweenPage.routeName,
//                   arguments: postCreator);
//             },
//           ); // end of myModalBottomSheet
//         },
//         splashRadius: 16.0,
//       ),
//     );
//   }
//
//   Container buildPostText(ThemeData appTheme) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: KAppPadding),
//       width: double.infinity,
//       child: ExpandableText(
//         widget.postContent,
//         //'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary,',
//         expandText: 'show more',
//         collapseText: 'show less',
//         linkColor: Colors.blue,
//         maxLines: 5,
//         textAlign: TextAlign.start,
//         style: appTheme.textTheme.bodyText1,
//         animation: true,
//         animationDuration: Duration(seconds: 1),
//       ),
//       //color: Colors.amber,
//     );
//   }
//
//   Widget buildPostImage(bool changeHeart, PostProvider postProvider) {
//     return GestureDetector(
//       onDoubleTap: () {
//         if (changeHeart == false) {
//           //Provider.of<PostProvider>(context,listen: false).likePost(postId: widget.postId, value: true,);
//           postProvider.likePost(
//             postCreatorId: widget.uId,
//             postId: widget.postId,
//             value: true,
//           );
//         }
//         setState(() {
//           isHeartAnimating = true;
//           //isLiked = true;
//         });
//       },
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           CachedNetworkImage(
//             imageUrl: widget.postImage,
//             fit: BoxFit.contain,
//             // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//             placeholder: (context, url) => Container(
//               // color: Colors.grey,
//               padding: EdgeInsets.all(KAppPadding * 2),
//               child: MyIcon(
//                 svgIcon: SvgIcon.Camera,
//                 color: Theme.of(context).accentColor.withOpacity(0.5),
//                 size: 48.0,
//               ),
//             ),
//             errorWidget: (context, url, error) => Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 MyIcon(
//                   svgIcon: SvgIcon.InfoSquare,
//                   color: Colors.redAccent,
//                   size: 48.0,
//                 ),
//                 MyHeightSizedBox(),
//                 Text(
//                   'Something Went Wrong!!',
//                   style: Theme.of(context).textTheme.subtitle1,
//                 ),
//               ],
//             ),
//           ),
//           Opacity(
//             opacity: isHeartAnimating == true ? 1 : 0,
//             child: HeartAnimationWidget(
//               isAnimating: isHeartAnimating,
//               onEnd: () {
//                 setState(() {
//                   isHeartAnimating = false;
//                 });
//               },
//               duration: Duration(milliseconds: 750),
//               child: Icon(
//                 Icons.favorite,
//                 color: Colors.white,
//                 size: 36.w,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class HeartAnimationWidget extends StatefulWidget {
//   final bool isAnimating;
//   final bool alwaysAnimating;
//   final Widget child;
//   final Duration duration;
//   final VoidCallback? onEnd;
//
//   const HeartAnimationWidget({
//     Key? key,
//     required this.isAnimating,
//     this.alwaysAnimating: false,
//     required this.child,
//     this.duration: const Duration(milliseconds: 150),
//     this.onEnd,
//   }) : super(key: key);
//
//   @override
//   _HeartAnimationWidgetState createState() => _HeartAnimationWidgetState();
// }
//
// class _HeartAnimationWidgetState extends State<HeartAnimationWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> scale;
//
//   @override
//   void initState() {
//     super.initState();
//     final halfDuration = widget.duration.inMilliseconds ~/ 2;
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: halfDuration),
//     );
//
//     scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
//   }
//
//   @override
//   void didUpdateWidget(covariant HeartAnimationWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//
//     if (widget.isAnimating != oldWidget.isAnimating) {
//       doAnimation();
//     }
//   }
//
//   Future doAnimation() async {
//     if (widget.isAnimating == true || widget.alwaysAnimating == true) {
//       await controller.forward();
//       await controller.reverse();
//       await Future.delayed(Duration(milliseconds: 200));
//       if (widget.onEnd != null) {
//         widget.onEnd!();
//       }
//     }
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
//     return ScaleTransition(
//       scale: scale,
//       child: widget.child,
//     );
//   }
// }
