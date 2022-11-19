// import 'package:firebase_auth/firebase_auth.dart';
//
// // import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
//
// abstract class AuthBase {
//   User get currentUser;
//
//   Stream<User?> authStateChanges();
//
//   //Future<User> loginWithEmailAndPassword({required String userEmail,required String userPassword});
//   Future<User?>? createUserWithEmailAndPassword({
//     required String userEmail,
//     required String userPassword,
//   });
//   Future<User?>? loginWithEmailAndPassword({required String userEmail, required String userPassword});
//
//   Future<void> signOut();
//
// // Future<User> signInAnonymously();
// //
// // Future<User> signInWithGoogle();
// //
// // Future<User> signInWithFacebook();
//
// }
//
// class Auth implements AuthBase {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   @override
//   User get currentUser =>
//       _firebaseAuth.currentUser!; //_firebaseAuth.currentUser
//
//   @override
//   Stream<User?> authStateChanges() {
//     return _firebaseAuth.authStateChanges(); //_firebaseAuth.authStateChanges()
//   }
//
//   @override
//   Future<User?>? createUserWithEmailAndPassword({
//     required String userEmail,
//     required String userPassword,
//   }) async{
//     var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: userEmail, password: userPassword);
//     return userCredential.user;
//   }
//
//   @override
//   Future<User?>? loginWithEmailAndPassword({required String userEmail, required String userPassword}) async{
//     var userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: userEmail, password: userPassword);
//     return userCredential.user;
//   }
//
//
//
//   @override
//   Future<void> signOut() async {
//     // final googleSignIn = GoogleSignIn();
//     // await googleSignIn.signOut();
//     // final facebookLogin = FacebookLogin();
//     // await facebookLogin.logOut();
//     await _firebaseAuth.signOut();
//   }
//
// // @override
// // Future<User> loginWithEmailAndPassword({required String userEmail, required String userPassword}) async{
// //   final  myUser =  await _firebaseAuth.signInWithCredential(EmailAuthProvider.credential(email: userEmail, password: userPassword));
// //   return myUser.user;
// // }
//
// // @override
// // Future<User> signInAnonymously() async {
// //   final userCredentials = await _firebaseAuth.signInAnonymously();
// //   return userCredentials.user;
// // }
// //
// // @override
// // Future<User> signInWithGoogle() async {
// //   final googleSignIn = GoogleSignIn();
// //   final googleUser = await googleSignIn.signIn();
// //   if (googleUser != null) {
// //     // if the user complete sign in process successfully.
// //     final googleAuth = await googleUser.authentication;
// //     if (googleAuth.idToken != null) {
// //       final userCredential = await _firebaseAuth.signInWithCredential(
// //           GoogleAuthProvider.credential(
// //             idToken: googleAuth.idToken,
// //             accessToken: googleAuth.accessToken,
// //           ));
// //       return userCredential.user;
// //     } else {
// //       //if idToken == null
// //       throw FirebaseAuthException(
// //         code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
// //         message: 'Missing Google ID Token',
// //       );
// //     }
// //   } else {
// //     //if googleUser == null
// //     throw FirebaseAuthException(
// //       code: 'ERROR_ABORTED_BY_USER',
// //       message: 'Sign in aborted by user',
// //     );
// //   }
// // }
// //
// //
// // @override
// // Future<User> signInWithFacebook() async {
// //
// //   final fb = FacebookLogin();
// //   final response = await fb.logIn(permissions: [
// //     FacebookPermission.publicProfile,
// //     FacebookPermission.email,
// //     FacebookPermission.userBirthday,
// //   ]);
// //   switch (response.status) {
// //     case FacebookLoginStatus.success:
// //       final accessToken = response.accessToken;
// //       final userCredential = await _firebaseAuth.signInWithCredential(
// //         FacebookAuthProvider.credential(accessToken.token),
// //       );
// //       return userCredential.user;
// //     case FacebookLoginStatus.cancel:
// //       throw FirebaseAuthException(
// //         code: 'ERROR_ABORTED_BY_USER',
// //         message: 'Sign in aborted by user',
// //       );
// //     case FacebookLoginStatus.error:
// //       throw FirebaseAuthException(
// //         code: 'ERROR_FACEBOOK_LOGIN_FAILED',
// //         message: response.error.developerMessage,
// //       );
// //     default:
// //       throw UnimplementedError();
// //   }
// // }
//
// }
