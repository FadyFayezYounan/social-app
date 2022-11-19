class ChatMessageModel {
  String? content;
  dynamic createdAt;
  String? senderId;
  String? receiverId;
  String? imageUrl;
  String? userName;
  ChatMessageModel? replyMessage;

  ChatMessageModel({
    this.content,
    this.createdAt,
    this.senderId,
    this.receiverId,
    this.imageUrl,
    this.userName,
    this.replyMessage,
  });

  ChatMessageModel.fromJson(json) {
    content = json['content'];
    createdAt = json['createdAt'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    imageUrl = json['imageUrl'];
    userName = json['userName'];
    replyMessage = json['replyMessage'] == null ? null : ChatMessageModel.fromJson(json['replyMessage']);
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'senderId': senderId,
      'createdAt': createdAt,
      'receiverId':receiverId,
      'imageUrl':imageUrl,
      'userName':userName,
      'replyMessage' : replyMessage == null ? null : replyMessage!.toJson(),
    };
  }
}
