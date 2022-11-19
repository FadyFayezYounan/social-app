import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/utils/user_preferences.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserProvider extends ChangeNotifier {

  final ImagePicker _picker = ImagePicker();
   XFile? _image;
   String? userPickedImage;
   void pickImage() async{
     try{
       _image = await _picker.pickImage(source: ImageSource.gallery);
       if(_image == null) return;
       final imageTemporary = File(_image!.path);
       final directory = await getApplicationDocumentsDirectory();
       final name = basename(imageTemporary.path);
       final imageFile = File('${directory.path}/$name');
       final newImage = await File(imageTemporary.path).copy(imageFile.path);
       userPickedImage = newImage.path;
       print(directory.path);
       print(_image!.path);
       notifyListeners();
     } on PlatformException catch(error){
       print('Failed to pick image : $error');
     }
   }

  void deleteUserPickedImage() {
    userPickedImage = null;
    notifyListeners();
  }
  UserModel _currentUser = UserModel(
    uId : '1',
    imagePath: 'https://images.unsplash.com/photo-1539501694464-21fafd55196e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
    imageUrl: 'https://images.unsplash.com/photo-1539501694464-21fafd55196e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
    name: 'Fady Fayez2',
    email: 'fadyfayez067@gmail.com2',
    bio: 'Bio2',
    phone: '012',
    //isDarkModeOn: false,
  );
   // bool isDarkModeOn = UserPreferences.getUserDarkMode(key: 'isDarkMode');
   // void changeDarkMode( bool value){
   //   isDarkModeOn = value;
   //   UserPreferences.setUserDarkMode(value: value, key: 'isDarkMode');
   //   notifyListeners();
   // }

  UserModel get getCurrentUserData{
    _currentUser = UserPreferences.getCurrentUser(userKey: KUserKey, currentUser: _currentUser);
    return _currentUser;
  }

  void setCurrentUser({required UserModel givenCurrentUser})async{
    _currentUser = givenCurrentUser;
    await UserPreferences.setCurrentUser(currentUser: _currentUser, userKey: KUserKey);
    await FirebaseFirestore.instance.collection('users').doc(_currentUser.uId).set(_currentUser.toJson());
    notifyListeners();
  }


  bool isLoading = false;

  void changeIsLoadingValue(bool newValue){
    isLoading = newValue;
    notifyListeners();
  }
   Future saveUserProfileImageToFirebaseFireStorage()async{
    print('upload the image');
    var putFile = await firebase_storage.FirebaseStorage.instance.ref().child('userProfileImages').child(Uri.file(_image!.path).pathSegments.last).putFile(File(_image!.path));
    var url = putFile.ref.getDownloadURL();

    return url;
  }

  Future updateUserInFirebaseFireStore(UserModel userModel)async{
    await FirebaseFirestore.instance.collection('users').doc(_currentUser.uId).set(userModel.toJson());
    FirebaseFirestore.instance.collection('users').doc(_currentUser.uId).update(userModel.toJson());
  }


  ///bottom nav bar
  int currentIndex = 0;

  void changeCurrentIndexValue(int newValue){
    currentIndex = newValue;
    notifyListeners();
  }


}
