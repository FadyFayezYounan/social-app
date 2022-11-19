import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'package:social_app/pages/edit_profile/edit_profile_page.dart';
import 'package:social_app/pages/profile/profile_widget.dart';
import 'package:social_app/pages/profile/user_buttons.dart';
import 'package:social_app/pages/profile/user_info_widget.dart';

import 'package:social_app/providers/user_provider.dart';


class ProfilePage extends StatelessWidget {
  static const routeName = '/profile-page';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        var currentUser = userProvider.getCurrentUserData;
        return ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: userProvider.getCurrentUserData.imageUrl!,
            ),
            UserInfoWidget(
              userName: currentUser.name!,
              userEmail: currentUser.email!,
              userBio: currentUser.bio!,
            ),
            UserButtons(
              firstButtonText: 'Log out',
              onFirstButtonPressed: () {
                FirebaseAuth.instance.signOut();
                Phoenix.rebirth(context);
              },
              secondButtonText: 'Edit Profile',
              onSecondButtonPressed: () {
                Navigator.pushNamed(context, EditProfilePage.routeName);
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
  }
}

// import 'package:flutter/material.dart';
// import 'package:social_app/common_widgets/build_app_bar.dart';
// import 'package:social_app/pages/edit_profile/edit_profile_page.dart';
// import 'package:social_app/pages/profile/profile_widget.dart';
// import 'package:social_app/pages/profile/user_buttons.dart';
// import 'package:social_app/pages/profile/user_info_widget.dart';
// import 'package:social_app/utils/user_preferences.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     final  user = UserPreferences.getUser();
//     return Scaffold(
//       appBar: buildAppBar(
//         context: context,
//         title: 'Profile Page',
//       ),
//       body: ListView(
//         physics: BouncingScrollPhysics(),
//         children: [
//           ProfileWidget(
//             imagePath: user.imagePath,
//           ),
//           UserInfoWidget(
//             userName: user.name,
//             userEmail: user.email,
//             userBio: user.bio,
//           ),
//           UserButtons(
//             onEditProfilePressed: ()async{
//               await Navigator.pushNamed(context, EditProfilePage.routeName);
//               setState(() {});
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
