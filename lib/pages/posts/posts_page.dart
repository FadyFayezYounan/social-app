import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/loading_page.dart';
import 'package:social_app/common_widgets/post_widget.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/pages/home/story_widget.dart';
import 'package:social_app/providers/post_provider.dart';
import 'package:sizer/sizer.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100.w,
          height: 16.h,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => StoryWidget(),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: Provider.of<PostProvider>(context, listen: false)
                .listenToAllPosts(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> postSnapshot) {
              if (postSnapshot.connectionState == ConnectionState.waiting) {
                return LoadingPage();
              }
              final allPosts = postSnapshot.data.docs;
              if (postSnapshot.data.docs.length == 0) {
                return Center(
                  child: Text('No posts yet!!'),
                );
              }
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: allPosts.length,
                itemBuilder: (context, index) => PostWidget(
                  postModel: PostModel.fromJson(allPosts[index]),
                  //ConvertFromSnapshotToModal.postModel(allPosts[index]),
                  postId: allPosts[index].id,
                ),
                separatorBuilder: (BuildContext context, int index) => Divider(),
              );
            },
          ),
        ),
      ],
    );
  }
}

// class PostsPage extends StatelessWidget {
//   const PostsPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Provider.of<PostProvider>(context,listen: false).listenToAllPosts(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> postSnapshot) {
//         if (postSnapshot.connectionState == ConnectionState.waiting) {
//           return LoadingPage();
//         }
//         final allPosts = postSnapshot.data.docs;
//         if (postSnapshot.data.docs.length == 0) {
//           return Center(
//             child: Text('No posts yet!!'),
//           );
//         }
//         //final postsDocs = postSnapshot.data.docs;
//         return ListView.separated(
//           physics: BouncingScrollPhysics(),
//           itemCount: allPosts.length,
//           itemBuilder: (context, index) => PostWidget(
//             uId: allPosts[index]['uId'],
//             userName: allPosts[index]['userName'],
//             userImage: allPosts[index]['userImage'],
//             createdAt: allPosts[index]['createdAt'],
//             postContent: allPosts[index]['postContent'],
//             postImage: allPosts[index]['postImage'],
//             postLikes: allPosts[index]['postLikes'],
//             postId: allPosts[index].id,
//             numberOfComments: allPosts[index]['numberOfComments'],
//           ),
//           separatorBuilder: (BuildContext context, int index) => Divider(),
//         );
//       },
//     );
//   }
// }
