
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/app_button.dart';
import 'package:social_app/common_widgets/custom_dialog.dart';
import 'package:social_app/common_widgets/my_sized_box.dart';
import 'package:social_app/common_widgets/my_text_filed.dart';
import 'package:social_app/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/home/home_page.dart';
import 'package:social_app/pages/register/register_page.dart';
import 'package:social_app/providers/auth_provider.dart';
import 'package:social_app/providers/user_provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  void loginButtonOnPressed(
    AuthProvider auth,
    UserProvider user,
    String email,
    String password,
  ) async {
    try {
      var currentUser = await auth.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('uId--------->(${currentUser.user!.uid})<----------');
      var userData = await auth.getUserDataById(uId: currentUser.user!.uid);
      //var userData = await auth.loginWithEmailAndPasswordAndGetUerData(email: email, password: password);
       user.setCurrentUser(givenCurrentUser: UserModel.fromJson(userData.data()!));

      print(user.getCurrentUserData.name);
      Navigator.pushReplacementNamed(context, HomePage.routeName);
      // Navigator.pushReplacementNamed(context, ProfilePage.routeName);
    } catch (error) {
      // var index = error.toString().indexOf(']') + 2;
      // buildCustomDialog(
      //     context: context,
      //     title: 'An Error Occurred',
      //     subTitle: '${error.toString().substring(index)}');
    } finally {
      // setState(() {
      //   _isLoading = false;
      // });

    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpened = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: KAppPadding),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                MyHeightSizedBox(),
                buildLogo(isKeyboardOpened),
                const SizedBox(
                  height: KAppPadding,
                ),
                MyTextFiled(
                  controller: emailController,
                  hintText: 'example@gmail.com',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_rounded),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hPadding: 0.0,
                  textFiledStyle: TextFiledStyle.UnderlineBorder,
                ),
                MyTextFiled(
                  controller: passwordController,
                  hintText: 'At least 8 characters',
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.password_rounded),
                  isPasswordTextFiled: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  hPadding: 0.0,
                  textFiledStyle: TextFiledStyle.UnderlineBorder,
                ),
                const SizedBox(
                  height: KAppPadding / 2,
                ),
                Consumer<UserProvider>(
                  builder: (context, user, child) => Consumer<AuthProvider>(
                    builder: (context, auth, child) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: AppButton(
                        text: 'Login',
                        loading: auth.loading,//_isLoading,
                        onPressed: () {
                          loginButtonOnPressed(
                            auth,
                            user,
                            emailController.text,
                            passwordController.text,
                          );
                        },
                        borderRadius: 48.0,
                      ),
                    ),
                  ),
                ),
                MyHeightSizedBox(),
                // buildOrWidget(context),
                // MyHeightSizedBox(),
                // buildSocialButtons(),
                MyHeightSizedBox(),
                buildDoNotHaveAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildLogo(bool isKeyboardOpened) {
    return AnimatedContainer(
      width: 100.w,
      height: isKeyboardOpened == true ? 0.0 : 30.h,
      duration: Duration(milliseconds: 320),
      child: Lottie.asset(
        'assets/lottie/man-chatting-on-his-mobile-phone.json',
        animate: true,
      ),
    );
  }

  Row buildOrWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Theme.of(context).accentColor.withOpacity(0.4),
          ),
        ),
        const Text('  OR  '),
        Expanded(
          child: Divider(
            color: Theme.of(context).accentColor.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  // Row buildSocialButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       GFIconButton(
  //         onPressed: () {},
  //         icon: Icon(Icons.facebook),
  //         shape: GFIconButtonShape.circle,
  //       ),
  //       const SizedBox(
  //         width: KAppPadding,
  //       ),
  //       GFIconButton(
  //         onPressed: () {},
  //         icon: Icon(Icons.g_mobiledata_rounded),
  //         shape: GFIconButtonShape.circle,
  //         color: Colors.redAccent,
  //       ),
  //     ],
  //   );
  // }

  Row buildDoNotHaveAccount(BuildContext context) {
    return Row(
      children: [
        Text('Don\'t have an account? '),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RegisterPage.routeName);
          },
          child: Text(
            'Register',
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:getwidget/components/button/gf_icon_button.dart';
// import 'package:getwidget/shape/gf_icon_button_shape.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:social_app/common_widgets/app_button.dart';
// import 'package:social_app/common_widgets/custom_dialog.dart';
// import 'package:social_app/common_widgets/my_sized_box.dart';
// import 'package:social_app/common_widgets/my_text_filed.dart';
// import 'package:social_app/constants.dart';
// import 'package:sizer/sizer.dart';
// import 'package:social_app/models/user_model.dart';
// import 'package:social_app/pages/edit_profile/edit_profile_page.dart';
// import 'package:social_app/pages/profile/profile_page.dart';
// import 'package:social_app/pages/register/register_page.dart';
// import 'package:social_app/providers/auth_provider.dart';
// import 'package:social_app/providers/user_provider.dart';
//
// class LogInPage extends StatefulWidget {
//   const LogInPage({Key? key}) : super(key: key);
//
//   @override
//   _LogInPageState createState() => _LogInPageState();
// }
//
// class _LogInPageState extends State<LogInPage> {
//   late TextEditingController emailController;
//   late TextEditingController passwordController;
//
//   @override
//   void initState() {
//     super.initState();
//     emailController = TextEditingController();
//     passwordController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }
//
//   bool _isLoading = false;
//
//   void loginButtonOnPressed(
//     AuthProvider auth,
//     UserProvider user,
//     String email,
//     String password,
//   ) async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       var currentUser = await auth.loginWithEmailAndPassword(
//           email: email, password: password);
//       var userData = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUser.user!.uid)
//           .get();
//       user.setCurrentUser(givenCurrentUser: UserModel.fromJson(userData.data()!));
//       Navigator.pushReplacementNamed(context, ProfilePage.routeName);
//     } catch (error) {
//       var index = error.toString().indexOf(']') + 2;
//       buildCustomDialog(
//           context: context,
//           title: 'An Error Occurred',
//           subTitle: '${error.toString().substring(index)}');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isKeyboardOpened = MediaQuery.of(context).viewInsets.bottom != 0;
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             padding: const EdgeInsets.symmetric(horizontal: KAppPadding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Login',
//                   style: Theme.of(context).textTheme.headline5,
//                   textAlign: TextAlign.center,
//                 ),
//                 MyHeightSizedBox(),
//                 buildLogo(isKeyboardOpened),
//                 const SizedBox(
//                   height: KAppPadding,
//                 ),
//                 MyTextFiled(
//                   controller: emailController,
//                   hintText: 'example@gmail.com',
//                   labelText: 'Email',
//                   prefixIcon: Icon(Icons.email_rounded),
//                   keyboardType: TextInputType.emailAddress,
//                   textInputAction: TextInputAction.next,
//                   hPadding: 0.0,
//                   // validator: (String enteredEmail){
//                   //   if(enteredEmail.isEmpty){
//                   //     return 'Email must not be empty';
//                   //   }
//                   //   return 'null';
//                   // },
//                 ),
//                 MyTextFiled(
//                   controller: passwordController,
//                   hintText: 'At least 8 characters',
//                   labelText: 'Password',
//                   prefixIcon: Icon(Icons.password_rounded),
//                   isPasswordTextFiled: true,
//                   keyboardType: TextInputType.visiblePassword,
//                   textInputAction: TextInputAction.done,
//                   hPadding: 0.0,
//                   // validator: (String enteredEmail){
//                   //   if(enteredEmail.isEmpty){
//                   //     return 'error';
//                   //   }
//                   //   return 'null';
//                   // },
//                 ),
//                 const SizedBox(
//                   height: KAppPadding / 2,
//                 ),
//                 Consumer<UserProvider>(
//                   builder: (context, user, child) => Consumer<AuthProvider>(
//                     builder: (context, auth, child) => _isLoading == true
//                         ? Center(child: CircularProgressIndicator())
//                         : AppButton(
//                             text: 'Login',
//                             onPressed: () {
//                               loginButtonOnPressed(
//                                 auth,
//                                 user,
//                                 emailController.text,
//                                 passwordController.text,
//                               );
//                             },
//                             vPadding: KAppPadding,
//                           ),
//                   ),
//                 ),
//                 MyHeightSizedBox(),
//                 buildOrWidget(context),
//                 MyHeightSizedBox(),
//                 buildSocialButtons(),
//                 MyHeightSizedBox(),
//                 buildDoNotHaveAccount(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   AnimatedContainer buildLogo(bool isKeyboardOpened) {
//     return AnimatedContainer(
//       width: 100.w,
//       height: isKeyboardOpened == true ? 0.0 : 30.h,
//       duration: Duration(milliseconds: 320),
//       child: Lottie.asset(
//         'assets/lottie/man-chatting-on-his-mobile-phone.json',
//         animate: true,
//       ),
//     );
//   }
//
//   Row buildOrWidget(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Divider(
//             color: Theme.of(context).accentColor.withOpacity(0.4),
//           ),
//         ),
//         const Text('  OR  '),
//         Expanded(
//           child: Divider(
//             color: Theme.of(context).accentColor.withOpacity(0.4),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Row buildSocialButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GFIconButton(
//           onPressed: () {},
//           icon: Icon(Icons.facebook),
//           shape: GFIconButtonShape.circle,
//         ),
//         const SizedBox(
//           width: KAppPadding,
//         ),
//         GFIconButton(
//           onPressed: () {},
//           icon: Icon(Icons.g_mobiledata_rounded),
//           shape: GFIconButtonShape.circle,
//           color: Colors.redAccent,
//         ),
//       ],
//     );
//   }
//
//   Row buildDoNotHaveAccount(BuildContext context) {
//     return Row(
//       children: [
//         Text('Don\'t have an account? '),
//         InkWell(
//           onTap: () {
//             Navigator.pushNamed(context, RegisterPage.routeName);
//           },
//           child: Text(
//             'Register',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
