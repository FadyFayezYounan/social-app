import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/services/firebase_storage_helper.dart';
import 'package:social_app/utils/user_preferences.dart';

class PostProvider extends ChangeNotifier {
  var _store = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? pickedImage;

  /// this method used to pick post image.
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

  /// this method used to delete post picked image.
  void deleteUserPickedImage() {
    _image = null;
    pickedImage = null;
    notifyListeners();
  }

  bool addNewPostLoading = false;

  void _changeLoadingPostValue(bool newValue) {
    addNewPostLoading = newValue;
    notifyListeners();
  }

  /// get currentUser from sharedPreferences.
  UserModel currentUser = UserPreferences.getUser(userKey: KUserKey);

  //String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  /// this method used to upload post text to firebase fireStore and upload post image to firebaseStorage.
  Future addNewPost({
    required Timestamp createdAt,
    required String postContent,
  }) async {
    _changeLoadingPostValue(true);
    try {
      if (pickedImage != null) {
        String url = await FirebaseStorageHelper.saveImageToFirebaseFireStorage(
          pickedImage: pickedImage!,
          directoryName: 'user_posts_images',
        );
        _savePostContentToFireStore(
          uId: currentUser.uId!,
          userName: currentUser.name!,
          userImage: currentUser.imageUrl!,
          postImage: url,
          createdAt: createdAt,
          postContent: postContent,
        );
        _changeLoadingPostValue(false);
      } else {
        _savePostContentToFireStore(
          uId: currentUser.uId!,
          userName: currentUser.name!,
          userImage: currentUser.imageUrl!,
          postImage: '',
          createdAt: createdAt,
          postContent: postContent,
        );
        _changeLoadingPostValue(false);
      }
    } catch (e) {
      print('------------------------------->$e');
    }
  }

  /// this method used to upload only post text to firebase fireStore.
  Future _savePostContentToFireStore({
    required String uId,
    required String userName,
    required String userImage,
    required String postImage,
    required Timestamp createdAt,
    required String postContent,
  }) async {
    PostModel _post = PostModel(
      uId: uId,
      userName: userName,
      userImage: userImage,
      createdAt: createdAt,
      postContent: postContent,
      postImage: postImage,
      postLikes: {},
      numberOfComments: 0,
    );
    try {
      await _store.collection('all_posts').add(_post.toJson());
      await _store
          .collection('users')
          .doc(uId)
          .collection('userPosts')
          .add(_post.toJson());
    } catch (error) {
      print('----{error while saving post content to firestore}--->$error');
    }
  }

  //List<PostModel> allPosts = [];
  //List<String> allPostsIds = [];

  // Future<StreamSubscription<QuerySnapshot<Map<String, dynamic>>>> getAllPostsListen() async {
  //   allPosts = [];
  //   allPostsIds = [];
  //   var listen = _store.collection('all_posts').orderBy('createdAt', descending: true).snapshots().listen((event) {
  //     event.docs.forEach((element) {
  //       allPostsIds.add(element.id);
  //       allPosts.add(PostModel.fromJson(element.data()));
  //     });
  //   });
  //   return listen;
  // }

  PostModel _convertFromSnapshotToPostModel(snapshot) {
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

  // Stream listenToAllPosts() {
  //   var snapshots = _store
  //       .collection('all_posts')
  //       .orderBy('createdAt', descending: true)
  //       .snapshots().map(_postsDataFromSnapshot);
  //   return snapshots;
  // }

  /// this method used to listen to posts.
  Stream listenToAllPosts() {
    var snapshots = _store
        .collection('all_posts')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return snapshots;
  }

  // Stream listenToUserPosts({required String uId}) {
  //   var snapshots = _store
  //       .collection('users')
  //       .doc(uId)
  //       .collection('userPosts')
  //       .orderBy('createdAt', descending: true)
  //       .snapshots();
  //   return snapshots;
  // }

  Future likePost({
    required String postId,
    required bool value,
    required String postCreatorId,
  }) async {
    try {
      await _store.collection('all_posts').doc(postId).update({
        'postLikes.${currentUser.uId}': value,
      });
      // print('----------------->$postCreatorId');
      // print('----------------->$postId');
      // await _store
      //     .collection('users')
      //     .doc(postCreatorId)
      //     .collection('userPosts')
      //     .doc(postId)
      //     .update({
      //   'postLikes.${currentUser.uId}': value,
      // });
    } catch (error) {
      print('--------{error while liking a post }---------->$error');
    }
  }

  Future deletePost({required String postId}) async {
    try {
      await _store.collection('all_posts').doc(postId).delete();
    } catch (error) {
      print('--------{error while deleting a post }---------->$error');
    }
  }

  /// this method used to get post creator data from firebase fireStore.
  UserModel postCreatorData = UserModel();

  Future getPostCreatorDataById({required String uId}) async {
    try {
      var response = await _store.collection('users').doc(uId).get();
      postCreatorData = UserModel.fromJson(response.data()!);
      notifyListeners();
    } catch (error) {
      print('-----{error while getting PostCreatorDataById }------>$error');
    }
  }
// List<PostModel> userPosts = [];
// List<String> userPostsIds = [];
//
// Future getUserPosts({required String uId}) async {
//   try {
//     userPosts = [];
//     userPostsIds = [];
//
//     var response = await _store
//         .collection('users')
//         .doc(uId)
//         .collection('userPosts')
//         .get();
//
//     response.docs.forEach((element) {
//       userPosts.add(PostModel.fromJson(element.data()));
//       userPostsIds.add(element.id);
//     });
//   } catch (error) {
//     print('--------{error while getting user posts }---------->$error');
//   }
// }
}

//import 'dart:async';
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:social_app/constants.dart';
// import 'package:social_app/models/post_model.dart';
// import 'package:social_app/models/user_model.dart';
// import 'package:social_app/services/firebase_storage_helper.dart';
// import 'package:social_app/utils/user_preferences.dart';
//
// class PostProvider extends ChangeNotifier {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _image;
//   File? pickedImage;
//
//   void pickImage() async {
//     try {
//       _image = await _picker.pickImage(
//           source: ImageSource.gallery, imageQuality: 50);
//       if (_image == null) return;
//       pickedImage = File(_image!.path);
//       print(pickedImage);
//       notifyListeners();
//     } on PlatformException catch (error) {
//       print('Failed to pick image : $error');
//     }
//   }
//
//   void deleteUserPickedImage() {
//     _image = null;
//     pickedImage = null;
//     notifyListeners();
//   }
//
//   // Future saveUserProfileImageToFirebaseFireStorage()async{
//   //   print('upload the image');
//   //   var putFile = await firebase_storage.FirebaseStorage.instance.ref().child('userProfileImages').child(Uri.file(_image!.path).pathSegments.last).putFile(File(_image!.path));
//   //   var url = putFile.ref.getDownloadURL();
//   //
//   //   return url;
//   // }
//
//   bool addNewPostLoading = false;
//
//   void _changeLoadingPostValue(bool newValue) {
//     addNewPostLoading = newValue;
//     notifyListeners();
//   }
//
//   UserModel currentUser = UserPreferences.getUser(userKey: KUserKey);
//
//   //String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//   Future addNewPost({
//     required Timestamp createdAt,
//     required String postContent,
//   }) async {
//     _changeLoadingPostValue(true);
//     try {
//       if (pickedImage != null) {
//         String url = await FirebaseStorageHelper.saveImageToFirebaseFireStorage(
//           pickedImage: pickedImage!,
//           directoryName: 'user_posts_images',
//         );
//         _savePostContentToFireStore(
//           uId: currentUser.uId,
//           userName: currentUser.name,
//           userImage: currentUser.imageUrl,
//           postImage: url,
//           createdAt: createdAt,
//           postContent: postContent,
//         );
//         _changeLoadingPostValue(false);
//       } else {
//         _savePostContentToFireStore(
//           uId: currentUser.uId,
//           userName: currentUser.name,
//           userImage: currentUser.imageUrl,
//           postImage: '',
//           createdAt: createdAt,
//           postContent: postContent,
//         );
//         _changeLoadingPostValue(false);
//       }
//     } catch (e) {
//       print('------------------------------->$e');
//     }
//   }
//
//   Future _savePostContentToFireStore({
//     required String uId,
//     required String userName,
//     required String userImage,
//     required String postImage,
//     required Timestamp createdAt,
//     required String postContent,
//   }) async {
//     PostModel _post = PostModel(
//       uId: uId,
//       userName: userName,
//       userImage: userImage,
//       createdAt: createdAt,
//       postContent: postContent,
//       postImage: postImage,
//       postLikes: {},
//       numberOfComments: 0,
//     );
//     try {
//       await FirebaseFirestore.instance
//           .collection('all_posts')
//           .add(_post.toJson());
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(uId)
//           .collection('userPosts')
//           .add(_post.toJson());
//     } catch (error) {
//       print(
//           '---------------{error while saving post content to firestore}---------------->$error');
//     }
//   }
//
//   //List<PostModel> allPosts = [];
//
//   // void getAllPosts() {
//   //   FirebaseFirestore.instance
//   //       .collection('all_posts')
//   //       .snapshots()
//   //       .listen((event) {
//   //     allPosts = [];
//   //     event.docs.forEach((element) {
//   //       allPosts.add(PostModel.fromJson(element.data()));
//   //     });
//   //   });
//   //
//   //   notifyListeners();
//   // }
//
//   //  Future getAllPosts() async {
//   //    FirebaseFirestore.instance
//   //       .collection('all_posts').orderBy('createdAt',descending: true)
//   //       .snapshots()
//   //       .listen((event) {
//   //     allPosts = [];
//   //     event.docs.forEach((element) {
//   //       allPosts.add(PostModel.fromJson(element.data()));
//   //     });
//   //   });
//   //   notifyListeners();
//   // }
//
//   ////////////////////////////////////////////////////////
//
//   // Future likeAPost({required String postId}) async {
//   //   try {
//   //     await FirebaseFirestore.instance
//   //         .collection('all_posts')
//   //         .doc(postId)
//   //         .collection('likes')
//   //         .doc(currentUser.uId)
//   //         .set({'like': true});
//   //   } catch (error) {
//   //     print(
//   //         '---------------{error while liking a post }---------------->$error');
//   //   }
//   // }
//   //
//   //  Future getPostNumberOfLikes({required String postId}) async {
//   //   try {
//   //     var numberOfLikes = await FirebaseFirestore.instance
//   //         .collection('all_posts')
//   //         .doc(postId)
//   //         .collection('likes')
//   //         .get();
//   //     return numberOfLikes.docs.length;
//   //   } catch (error) {
//   //     print(
//   //         '---------------{error while liking a post }---------------->$error');
//   //   }
//   // }
//
//   Future likePost({
//     required postId,
//     required bool value,
//   }) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('all_posts')
//           .doc(postId)
//           .update({
//         'postLikes.${currentUser.uId}': value,
//       });
//       //print('like method called');
//     } catch (error) {
//       print('--------{error while liking a post }---------->$error');
//     }
//   }
//
//   Future deletePost({required String postId}) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('all_posts')
//           .doc(postId)
//           .delete();
//     } catch (error) {
//       print('--------{error while deleting a post }---------->$error');
//     }
//   }
//
//   List<PostModel> userPosts = [];
//   List<String> userPostsIds = [];
//   Future getUserPosts({required String uId}) async {
//     try{
//       userPosts = [];
//       userPostsIds = [];
//
//       var response = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(uId)
//           .collection('userPosts')
//           .get();
//
//
//       response.docs.forEach((element) {
//         userPosts.add(PostModel.fromJson(element.data()));
//         userPostsIds.add(element.id);
//       });
//
//     }catch(error){
//       print('--------{error while getting user posts }---------->$error');
//     }
//   }
// }
