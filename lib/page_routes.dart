import 'package:social_app/pages/chat/chat_between_page.dart';
import 'package:social_app/pages/comments/comments_page.dart';
import 'package:social_app/pages/edit_profile/edit_profile_page.dart';
import 'package:social_app/pages/home/home_page.dart';
import 'package:social_app/pages/profile/profile_page.dart';
import 'package:social_app/pages/register/register_page.dart';
import 'package:social_app/pages/user_profile_info/user_info_page.dart';
import 'package:social_app/pages/write_post/write_post_page.dart';

dynamic pageRoutes = {
  EditProfilePage.routeName: (_) => EditProfilePage(),
  //SettingsPage.routeName: (_) => SettingsPage(),
  RegisterPage.routeName: (_) => RegisterPage(),
  ProfilePage.routeName: (_) => ProfilePage(),
  WritePostPage.routeName: (_) => WritePostPage(),
  CommentsPage.routeName: (_) => CommentsPage(),
  HomePage.routeName: (_) => HomePage(),
  ChatBetweenPage.routeName: (_) => ChatBetweenPage(),
 UserProfileInfoPage.routeName : (_) => UserProfileInfoPage(),
};
