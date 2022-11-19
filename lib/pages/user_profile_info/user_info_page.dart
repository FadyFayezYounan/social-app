import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/error_widget.dart';

import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/common_widgets/my_icon_button.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/chat/chat_between_page.dart';

import 'package:social_app/pages/profile/profile_widget.dart';
import 'package:social_app/pages/profile/user_buttons.dart';
import 'package:social_app/pages/profile/user_info_widget.dart';
import 'package:social_app/providers/post_provider.dart';

class UserProfileInfoPage extends StatelessWidget {
  static const routeName = '/user-profile-info-page';

  const UserProfileInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final creatorId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: MyIconButton(
          svgIcon: SvgIcon.ArrowLeftCircle,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<PostProvider>(context, listen: false)
            .getPostCreatorDataById(uId: creatorId),
        builder: (BuildContext context, postCreatorSnapshot) {
          if (postCreatorSnapshot.connectionState == ConnectionState.waiting) {
            //return Center(child: MyLoader());
            return Center(child: CircularProgressIndicator());
          }
          if (postCreatorSnapshot.error != null) {
            return ErrorOccurredWidget();
          }
          return Consumer<PostProvider>(
            builder: (context, postProvider, child) {
              var postCreatorData = postProvider.postCreatorData;
              return ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ProfileWidget(
                    imagePath: postCreatorData.imageUrl!,
                  ),
                  UserInfoWidget(
                    userName: postCreatorData.name!,
                    userEmail: postCreatorData.email!,
                    userBio: postCreatorData.bio!,
                  ),
                  UserButtons(
                    firstButtonText: 'Follow',
                    onFirstButtonPressed: () {},
                    secondButtonText: 'Message',
                    onSecondButtonPressed: () {
                      UserModel postCreator = UserModel(
                        uId: postCreatorData.uId,
                        imageUrl: postCreatorData.imageUrl,
                        name: postCreatorData.name,
                        email: '',
                        imagePath: '',
                        bio: '',
                      );
                      Navigator.pushNamed(
                        context,
                        ChatBetweenPage.routeName,
                        arguments: postCreator,
                      );
                    },
                  ),
                  // SizedBox(
                  //   width: 100.w,
                  //   height: 100.h,
                  //   child: FutureBuilder(
                  //     future: Provider.of<PostProvider>(context, listen: false)
                  //         .getUserPosts(uId: currentUser.uId),
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<dynamic> userPostsSnapshot) {
                  //       if (userPostsSnapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return Center(child: MyLoader());
                  //       }
                  //       return Consumer<PostProvider>(
                  //         builder: (context, postProvider, child){
                  //           var userPosts = postProvider.userPosts;
                  //           return ListView.builder(
                  //               shrinkWrap: true,
                  //               physics: NeverScrollableScrollPhysics(),
                  //               // physics: ScrollPhysics(),
                  //               itemCount: userPosts.length,
                  //               //userPosts.length,
                  //               itemBuilder: (context, index) {
                  //                 return PostWidget(
                  //                   uId: userPosts[index].uId!,
                  //                   postLikes: userPosts[index].postLikes!,
                  //                   postId: postProvider.userPostsIds[index],
                  //                   postImage: userPosts[index].postImage!,
                  //                   userImage: userPosts[index].userImage!,
                  //                   createdAt: userPosts[index].createdAt!,
                  //                   postContent: userPosts[index].postContent!,
                  //                   userName: userPosts[index].userName!,
                  //                 );
                  //               });
                  //         },
                  //       );
                  //     },
                  //   ),
                  // )
                  // SizedBox(
                  //   width: 100.w,
                  //   height: 100.h,
                  //   child: StreamBuilder(
                  //     stream: Provider.of<PostProvider>(context,listen: false).listenToUserPosts(uId: currentUser.uId),
                  //     builder: (BuildContext context, AsyncSnapshot<dynamic> postSnapshot) {
                  //       if (postSnapshot.connectionState == ConnectionState.waiting) {
                  //         return Center(child: MyLoader());
                  //       }
                  //       final allPosts = postSnapshot.data.docs;
                  //       if (postSnapshot.data.docs.length == 0) {
                  //         return Center(
                  //           child: Text('No posts yet!!'),
                  //         );
                  //       }
                  //       //final postsDocs = postSnapshot.data.docs;
                  //       return ListView.separated(
                  //         shrinkWrap: true,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemCount: allPosts.length,
                  //         itemBuilder: (context, index) => PostWidget(
                  //           uId: allPosts[index]['uId'],
                  //           userName: allPosts[index]['userName'],
                  //           userImage: allPosts[index]['userImage'],
                  //           createdAt: allPosts[index]['createdAt'],
                  //           postContent: allPosts[index]['postContent'],
                  //           postImage: allPosts[index]['postImage'],
                  //           postLikes: allPosts[index]['postLikes'],
                  //           postId: allPosts[index].id,
                  //           numberOfComments: allPosts[index]['numberOfComments'],
                  //         ),
                  //         separatorBuilder: (BuildContext context, int index) => Divider(),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
