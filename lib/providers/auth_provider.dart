import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  var _auth = FirebaseAuth.instance;
  var _store = FirebaseFirestore.instance;

  bool loading = false;

  void _changeLoadingValue(bool newValue) {
    loading = newValue;
    notifyListeners();
  }

  Future loginWithEmailAndPasswordAndGetUerData({
    required String email,
    required String password,
  }) async{
    var response = await loginWithEmailAndPassword(email: email, password: password);
    var userData = await getUserDataById(uId: response.user!.uid);
    return userData;
  }

  Future getUserDataById({required String uId}) async {
    var userData = await _store.collection('users').doc(uId).get();
    return userData;
  }

  Future<UserCredential> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    _changeLoadingValue(true);

    ///login in with email and password.
    var response = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // /// get user Data from firebase fireStore.
    //  var userData = await getUserDataById(uId: response.user!.uid);
    // _changeLoadingValue(false);
    return response;
  }

  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    saveUserData(
      uId: userCredential.user!.uid,
      email: email,
      phone: phone,
      name: name,
    );
    return userCredential;
  }

  void saveUserData({
    required String uId,
    required String email,
    required String phone,
    required String name,
  }) async {
    UserModel userModel = UserModel(
      uId: uId,
      imagePath:
          'https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
      imageUrl:
          'https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
      name: name,
      email: email,
      bio: 'bio',
      phone: phone,
      //isDarkModeOn: false,
    );
    try {
      ///save user data on firebase
      await _store.collection('users').doc(uId).set(userModel.toJson());

      ///save user data local
      //await UserPreferences.setCurrentUser(currentUser: userModel, userKey: KUserKey);

    } catch (error) {
      print(
          'Error while saving user data to firebase fire store ${error.toString()}');
    }
  }

// Future<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uId) async {
//   var userData = await _store.collection('users').doc(uId).get();
//   return userData;
// }

//  void loginWithEmailAndPassword({required String email , required String password}) async {
//
//   var signInWithEmailAndPassword = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
//   // print('UID----->>>>>>>>>>>>${signInWithEmailAndPassword.user!.uid}');
//
// }

}
