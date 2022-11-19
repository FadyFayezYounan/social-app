import 'package:cloud_firestore/cloud_firestore.dart';


class PostModel {
  String? uId;
  //String postId;
  String? userName;
  String? userImage;
  Timestamp? createdAt;
  String? postContent;
  String? postImage;
  Map? postLikes;
  int? numberOfComments;

  PostModel({
     this.uId,
    //this.postId,
     this.userName,
     this.userImage,
     this.createdAt,
     this.postContent,
     this.postImage,
     this.postLikes,
     this.numberOfComments,
  });

  // static PostModel fromJson(Map<String, dynamic> json) {
  //   return PostModel(
  //     uId : json['uId'],
  //     userName : json['name'],
  //     userImage : json['image'],
  //     postImage : json['postImage'],
  //     createdAt : json['createdAt'],
  //     postContent : json['content'],
  //   );
  // }

  PostModel.fromJson(json){
    uId = json['uId'];
    userName = json['userName'];
    userImage = json['userImage'];
    postImage = json['postImage'];
    createdAt = json['createdAt'];
    postContent = json['postContent'];
    postLikes = json['postLikes'];
    numberOfComments = json['numberOfComments'];

  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'userName': userName,
      'userImage': userImage,
      'postImage': postImage,
      'createdAt': createdAt,
      'postContent': postContent,
      'postLikes' : postLikes,
      'numberOfComments' : numberOfComments,
    };
  }
}
