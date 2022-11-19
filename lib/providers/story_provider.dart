import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:social_app/models/story_modal.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/utils/user_preferences.dart';

import '../constants.dart';

class StoryProvider extends ChangeNotifier {
  UserModel _currentUser = UserPreferences.getUser(userKey: KUserKey);
  var _store = FirebaseFirestore.instance;

  Future saveNewStory(
      {required String content, required Timestamp createdAt}) async {
    StoryModel storyModel = StoryModel(
      userImage: _currentUser.imageUrl,
      userName: _currentUser.name,
      uId: _currentUser.uId,
      createdAt: createdAt,
      content: content,
    );
    await _store
        .collection('users')
        .doc(_currentUser.uId)
        .collection('stories')
        .add(storyModel.toJson());
  }
}
