import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/models/user_model.dart';

class UserPreferences {
  static late SharedPreferences _sharedPreferences;
  static const myUser = UserModel(
    uId: '1',
    imagePath: 'https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
    imageUrl: 'https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
    name: 'Fady Fayez',
    email: 'fadyfayez067@gmail.com',
    bio: 'Bio',
      //isDarkModeOn: false,
    phone: '012',
  );

  static Future init()async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // static Future setUser(User user) async{
  //   final json = jsonEncode(user.toJson());
  //   await _sharedPreferences.setString(_userKey, json);
  // }
  //
  // static User getUser() {
  //   final json = _sharedPreferences.getString(_userKey);
  //   return json == null ? myUser : User.fromJson(jsonDecode(json));
  // }
///////////////////////////
  // static Future setUserDarkMode ({required bool value , required String key})async{
  //  await _sharedPreferences.setBool(key, value);
  // }
  // static bool getUserDarkMode ({required String key}){
  //   return false;
  // }
  static UserModel getUser({required String userKey}) {
    final json = _sharedPreferences.getString(userKey);
    return json == null ? myUser : UserModel.fromJson(jsonDecode(json));
  }
  static UserModel getCurrentUser({required String userKey , required UserModel currentUser}) {
    final json = _sharedPreferences.getString(userKey);
    return json == null ? currentUser : UserModel.fromJson(jsonDecode(json));
  }
  static Future setCurrentUser({required UserModel currentUser , required String userKey}) async{
    final json = jsonEncode(currentUser.toJson());
    await _sharedPreferences.setString(userKey, json);
  }
}
