import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:social_app/models/comment_model.dart';

class CommentProvider extends ChangeNotifier {
  bool loading = false;

  void _changeLoadingValue(bool newValue) {
    loading = newValue;
    notifyListeners();
  }

  Future saveCommentContentToFireStore({
    required String uId,
    required String postId,
    required String userName,
    required String userImage,
    required Timestamp createdAt,
    required String commentContent,
  }) async {
    CommentModel commentModel = CommentModel(
      uId: uId,
      userName: userName,
      userImage: userImage,
      createdAt: createdAt,
      commentContent: commentContent,
      commentLikes: {},
    );
    try {
      _changeLoadingValue(true);
      await FirebaseFirestore.instance
          .collection('all_posts')
          .doc(postId)
          .collection('post_comments')
          .add(commentModel.toJson());
      _changeLoadingValue(false);
    } catch (error) {
      print('---{error while saving comment content to firestore}--->$error');
    }
  }

  Stream listenToPostComments({required postId}) {
    var snapshots = FirebaseFirestore.instance
        .collection('all_posts')
        .doc(postId)
        .collection('post_comments')
        .orderBy('createdAt',descending: true)
        .snapshots();
    return snapshots;
  }

  // Future increaseNumberOfComments(
  //     {required String postId,
  //     required int currentCommentsNumber,
  //     required int increasedBy}) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('all_posts')
  //         .doc(postId)
  //         .update({
  //       'numberOfComments': currentCommentsNumber + increasedBy,
  //     });
  //   } catch (error) {
  //     print('--------{error while increaseNumberOfComments }---------->$error');
  //   }
  // }
}
