import 'package:social_app/models/chat_message_model.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';

class ConvertFromSnapshotToModal {
  static ChatMessageModel chatMessageModel(snapshot) {
    return ChatMessageModel(
      senderId: snapshot['senderId'],
      receiverId: snapshot['receiverId'],
      content: snapshot['content'],
      imageUrl: snapshot['imageUrl'],
      createdAt: snapshot['createdAt'],
    );
  }

  static PostModel postModel(snapshot) {
    return PostModel(
      uId: snapshot['uId'],
      userName: snapshot['userName'],
      userImage: snapshot['userImage'],
      createdAt: snapshot['createdAt'],
      postContent: snapshot['postContent'],
      postImage: snapshot['postImage'],
      postLikes: snapshot['postLikes'],
      numberOfComments: snapshot['numberOfComments'],
    );
  }

  static CommentModel commentModel(snapshot) {
    return CommentModel(
      uId: snapshot['uId'],
      userName: snapshot['userName'],
      userImage: snapshot['userImage'],
      commentContent: snapshot['commentContent'],
      createdAt: snapshot['createdAt'],
      commentLikes: snapshot['commentLikes'],
    );
  }
}
