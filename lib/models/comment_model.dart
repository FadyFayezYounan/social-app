import 'package:cloud_firestore/cloud_firestore.dart';


class CommentModel {
  String? uId;
  String? userName;
  String? userImage;
  Timestamp? createdAt;
  String? commentContent;
  //String? postImage;
  Map? commentLikes;

  CommentModel({
    required this.uId,
    //this.postId,
    required this.userName,
    required this.userImage,
    required this.createdAt,
    required this.commentContent,
    //required this.postImage,
    required this.commentLikes,
  });



  CommentModel.fromJson(json){
    uId = json['uId'];
    userName = json['userName'];
    userImage = json['userImage'];
    //postImage = json['postImage'];
    createdAt = json['createdAt'];
    commentContent = json['commentContent'];
    commentLikes = json['commentLikes'];

  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'userName': userName,
      'userImage': userImage,
      //'postImage': postImage,
      'createdAt': createdAt,
      'commentContent': commentContent,
      'commentLikes' : commentLikes,
    };
  }
}
