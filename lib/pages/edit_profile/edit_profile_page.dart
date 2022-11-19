import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/custom_dialog.dart';
import 'package:social_app/common_widgets/loading_page.dart';
import 'package:social_app/common_widgets/my_dialog.dart';
import 'package:social_app/common_widgets/my_icon_button.dart';
import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/pages/edit_profile/text_field_widget.dart';
import 'package:social_app/pages/edit_profile/user_edit_image.dart';
import 'package:social_app/providers/user_provider.dart';


class EditProfilePage extends StatelessWidget {
  static const routeName = '/edit-profile-page';

  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        var user = userProvider.getCurrentUserData;
        return userProvider.isLoading == true ?LoadingPage():Scaffold(
          appBar: AppBar(
            leading: MyIconButton(
              svgIcon: SvgIcon.CloseSquare,
              onPressed: () {
                userProvider.deleteUserPickedImage();
                Navigator.pop(context);
              },
            ),
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                Text(
                  '${user.name}',
                  style: appTextTheme.bodyText2,
                ),
                Text(
                  'edit profile',
                  style: appTextTheme.headline6,
                ),
              ],
            ),
            actions: [
              MyIconButton(
                svgIcon: SvgIcon.TickSquare,
                iconColor: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (user.name!.trim().isEmpty) {
                    buildMyDialog(
                      context: context,
                      title: 'Check your inputs!!',
                      subTitle: 'User name must not be empty.',
                    );
                  } else if (user.email!.trim().isEmpty) {
                    buildMyDialog(
                      context: context,
                      title: 'Check your inputs!!',
                      subTitle: 'User email must not be empty.',
                    );
                  } else if (!user.email!.trim().contains('@') ||
                      !user.email!.trim().contains('gmail.com') ||
                      user.email!.trim().length < 14) {
                    buildMyDialog(
                      context: context,
                      title: 'Check your inputs!!',
                      subTitle: 'Please enter a valid email address.',
                    );
                  } else if (user.name!.trim().length < 4) {
                    buildMyDialog(
                      context: context,
                      title: 'Check your inputs!!',
                      subTitle: 'User name must not less than 4 letters.',
                    );
                  } else {
                    try {
                      userProvider.changeIsLoadingValue(true);
                       //Future.delayed(Duration(seconds: 5));
                      if (userProvider.userPickedImage != null) {
                        var imageUrl = await userProvider
                            .saveUserProfileImageToFirebaseFireStorage();
                        user = user.copy(
                          imagePath: userProvider.userPickedImage,
                          imageUrl: imageUrl,
                        );
                      }
                      userProvider.setCurrentUser(givenCurrentUser: user);
                      userProvider.updateUserInFirebaseFireStore(user);
                      userProvider.changeIsLoadingValue(false);
                      Navigator.pop(context);
                    } catch (error) {
                      buildCustomDialog(
                        title: 'An Error Occurred',
                        subTitle: error.toString(),
                        context: context,
                      );
                    }

                    //Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  UserEditImage(
                    imagePath: userProvider.userPickedImage == null
                        ? user.imagePath!
                        : userProvider.userPickedImage!,
                    onButtonPressed: () {
                      userProvider.pickImage();
                    },
                  ),
                  TextFiledWidget(
                    leadingText: 'Name',
                    text: user.name!,
                    hintText: 'Name',
                    onChanged: (name) {
                      user = user.copy(name: name);
                    },
                  ),
                  TextFiledWidget(
                    leadingText: 'Email',
                    text: user.email!,
                    hintText: 'Email',
                    onChanged: (email) {
                      user = user.copy(email: email);
                    },
                  ),
                  TextFiledWidget(
                    leadingText: 'Phone',
                    text: '${user.phone}',
                    hintText: 'Phone',
                    onChanged: (phone) {
                      user = user.copy(phone: phone);
                    },
                  ),
                  TextFiledWidget(
                    leadingText: 'Bio',
                    text: user.bio!,
                    hintText: 'Bio',
                    onChanged: (bio) {
                      user = user.copy(bio: bio);
                    },
                    maxLines: 3,
                  ),
                  // if(userProvider.isLoading == true)
                  //   MyLoader(),
                ],
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:social_app/common_widgets/my_icon_button.dart';
// import 'package:social_app/common_widgets/my_icon.dart';
// import 'package:social_app/pages/edit_profile/text_field_widget.dart';
// import 'package:social_app/pages/edit_profile/user_edit_image.dart';
// import 'package:social_app/utils/user_preferences.dart';
//
// class EditProfilePage extends StatelessWidget {
//   static const routeName = '/edit-profile-page';
//
//   const EditProfilePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //var user = UserPreferences.myUser;
//     var user = UserPreferences.getUser();
//     final appTextTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       appBar: AppBar(
//         leading: MyIconButton(
//           svgIcon: SvgIcon.CloseSquare,
//           onPressed: (){
//             Navigator.pop(context);
//           },
//         ),
//         automaticallyImplyLeading: false,
//         title: Column(
//           children: [
//             Text(
//               '${user.name}',
//               style: appTextTheme.bodyText2,
//             ),
//             Text(
//               'edit profile',
//               style: appTextTheme.headline6,
//             ),
//           ],
//         ),
//         actions: [
//           MyIconButton(
//             svgIcon: SvgIcon.TickSquare,
//             iconColor: Theme.of(context).primaryColor,
//             onPressed: (){
//               UserPreferences.setUser(user);
//               Navigator.pop(context);
//
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           ListView(
//             physics: BouncingScrollPhysics(),
//             children: [
//               UserEditImage(
//                 imagePath: user.imagePath,
//                 onButtonPressed: () {
//                   print('edit image');
//                 },
//               ),
//               TextFiledWidget(
//                 leadingText: 'Name',
//                 text: user.name,
//                 hintText: 'Name',
//                 onChanged: (name) {
//                   user = user.copy(name: name);
//                 },
//               ),
//               TextFiledWidget(
//                 leadingText: 'Email',
//                 text: user.email,
//                 hintText: 'Email',
//                 onChanged: (email) {
//                   user = user.copy(email: email);
//                 },
//               ),
//               TextFiledWidget(
//                 leadingText: 'Bio',
//                 text: user.bio,
//                 hintText: 'Bio',
//                 onChanged: (bio) {
//                   user = user.copy(bio: bio);
//                 },
//                 maxLines: 3,
//               ),
//
//             ],
//           ),
//           Divider(),
//         ],
//       ),
//     );
//   }
// }
