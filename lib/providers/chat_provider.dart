import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/chat_message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/services/firebase_storage_helper.dart';
import 'package:social_app/utils/user_preferences.dart';

import '../constants.dart';

class ChatProvider extends ChangeNotifier {
  var _store = FirebaseFirestore.instance;

  UserModel _currentUser = UserPreferences.getUser(userKey: KUserKey);

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? pickedImage;

  void pickImage() async {
    try {
      _image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (_image == null) return;
      pickedImage = File(_image!.path);
      print(pickedImage);
      notifyListeners();
    } on PlatformException catch (error) {
      print('Failed to pick image : $error');
    }
  }

  void deleteUserPickedImage() {
    _image = null;
    pickedImage = null;
    notifyListeners();
  }

  List<UserModel> userFriends = [];

  Future getCurrentUserFriends() async {
    try {
      userFriends = [];
      var response = await _store.collection('users').get();
      response.docs.forEach((element) {
        if (UserModel.fromJson(element.data()).uId != _currentUser.uId) {
          userFriends.add(UserModel.fromJson(element.data()));
        }
      });
      //print(response.docs.length);
      notifyListeners();
    } catch (error) {
      print('--------{error while getting user friends }---------->$error');
    }
  }

  bool loading = false;

  void _changeLoadingValue(bool newValue) {
    loading = newValue;
    notifyListeners();
  }

  Future sendMessage({
    required String receiverId,
    required String content,
    required Timestamp createdAt,
    ChatMessageModel? replyMessage,
  }) async {
    _changeLoadingValue(true);
    try {
      if (pickedImage != null) {
        String url = await FirebaseStorageHelper.saveImageToFirebaseFireStorage(
          pickedImage: pickedImage!,
          directoryName: 'user_chats_images',
        );
        _saveMessageText(
          receiverId: receiverId,
          content: content,
          createdAt: createdAt,
          imageUrl: url,
          replyMessage: replyMessage,
        );
        _changeLoadingValue(false);
      } else {
        _saveMessageText(
          receiverId: receiverId,
          content: content,
          createdAt: createdAt,
          imageUrl: '',
          replyMessage: replyMessage,
        );
        _changeLoadingValue(false);
      }
    } catch (error) {}
  }

  Future _saveMessageText({
    required String receiverId,
    required String content,
    required Timestamp createdAt,
    required String imageUrl,
    ChatMessageModel? replyMessage,
  }) async {
    ChatMessageModel messageModel = ChatMessageModel(
      senderId: _currentUser.uId,
      receiverId: receiverId,
      content: content,
      createdAt: createdAt,
      imageUrl: imageUrl,
      userName : _currentUser.name,
      replyMessage: replyMessage,
    );
    try {
      ///save the message to current user chat.
      await _store
          .collection('users')
          .doc(_currentUser.uId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(messageModel.toJson());

      ///save the message to receiver chat.
      await _store
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(_currentUser.uId)
          .collection('messages')
          .add(messageModel.toJson());
    } catch (error) {
      print('--------{error while sending user message}---------->$error');
    }
  }

  // ChatMessageModel _convertFromSnapshotToChatMessageModel(snapshot) {
  //   return ChatMessageModel(
  //     senderId: snapshot['senderId'],
  //     receiverId:snapshot['receiverId'],
  //     content: snapshot['content'],
  //     imageUrl: snapshot['imageUrl'],
  //     createdAt:  snapshot['createdAt'],
  //   );
  // }
  Stream listenToChats({
    required String receiverId,
  }) {
    var snapshots = _store
        .collection('users')
        .doc(_currentUser.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots();
    return snapshots;
  }
  Future deleteMessage(
      {required String messageId, required String receiverId}) async {
    // ChatMessageModel messageModel = ChatMessageModel(
    //   senderId: _currentUser.uId,
    //   receiverId: receiverId,
    //   content: 'this message deleted.',
    //   createdAt: '',
    //   imageUrl: '',
    // );

    try {
      // ///save the message to current user chat.
      // await _store
      //     .collection('users')
      //     .doc(_currentUser.uId)
      //     .collection('chats')
      //     .doc(receiverId)
      //     .collection('messages')
      //     .doc(messageId)
      //     .update(messageModel.toJson());
      //
      // ///save the message to receiver chat.
      // await _store
      //     .collection('users')
      //     .doc(receiverId)
      //     .collection('chats')
      //     .doc(_currentUser.uId)
      //     .collection('messages')
      //     .doc(messageId)
      //     .update(messageModel.toJson());
      ///delete the message from the current user chat.
      await _store
          .collection('users')
          .doc(_currentUser.uId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .doc(messageId)
          .delete();
      ///delete the message from the receiver user chat.
      await _store
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(_currentUser.uId)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (error) {
      print('--------{error while deleting user message}---------->$error');
    }
  }




  ChatMessageModel? replyMessage;

  void replayToMessage(ChatMessageModel message){
    replyMessage = message;
    notifyListeners();
  }

  void deleteReplyMessage(){
    replyMessage = null;
    notifyListeners();
  }

}
