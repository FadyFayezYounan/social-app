import 'package:flutter/foundation.dart';

class StoryModel {
  String? uId;
  String? userImage;
  String? userName;
  String? content;
  dynamic createdAt;

  //int? colorIndex;

  StoryModel({
    this.uId,
    this.userImage,
    this.userName,
    this.content,
    this.createdAt,
    //this.colorIndex,
  });

  StoryModel.fromJson(Map<String, dynamic> json){
    uId = json['uId'];
    userImage = json['userImage'];
    userName = json['userName'];
    content = json['content'];
    createdAt = json['createdAt'];
    //colorIndex = json['colorIndex'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'userImage': userImage,
      'userName': userName,
      'content': content,
      'createdAt': createdAt,
      //'colorIndex':colorIndex,
    };
  }
}