// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:social_app/app_theme.dart';
// import 'package:social_app/providers/user_provider.dart';
//
// class SettingsPage extends StatelessWidget {
//   static const routeName = '/settings-page';
//
//   const SettingsPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ThemeSwitchingArea(
//       child: Builder(
//         builder: (context) => Scaffold(
//           appBar: AppBar(
//             title: Text('Settings'),
//           ),
//           body: ListView(
//             physics: BouncingScrollPhysics(),
//             children: [
//               //SettingsSwitchTile(),
//               AppThemeSwitcher(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class AppThemeSwitcher extends StatefulWidget {
//   const AppThemeSwitcher({Key? key}) : super(key: key);
//
//   @override
//   _AppThemeSwitcherState createState() => _AppThemeSwitcherState();
// }
//
// class _AppThemeSwitcherState extends State<AppThemeSwitcher> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return ListTile(
//       title: Text(
//         'Dark Mode',
//         style: Theme.of(context).textTheme.subtitle1,
//       ),
//       subtitle: Text(
//         'Change app theme(dark or light)',
//         style: Theme.of(context).textTheme.bodyText2,
//       ),
//       trailing: ThemeSwitcher(
//         builder: (context)=>Consumer<UserProvider>(
//           builder: (context,userProvider,child){
//             var user = userProvider.getCurrentUserData;
//             var switchValue = user.isDarkModeOn;
//             return Switch(
//               activeColor: Theme.of(context).primaryColor,
//               // inactiveTrackColor: Theme.of(context).accentColor.withOpacity(0.5),
//               // activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.5),//Theme.of(context).primaryColor.withOpacity(0.5),
//
//               value: switchValue,
//               onChanged: (value) {
//                 final switcher = ThemeSwitcher.of(context);
//                 setState(() {
//                   switchValue = value;
//                   if (value == true) {
//                     final newUserData = user.copy(isDarkModeOn: true);
//                     userProvider.setCurrentUser(givenCurrentUser: newUserData);
//                     switcher!.changeTheme(theme: AppTheme.darkTheme());
//                   } else {
//                     final newUserData = user.copy(isDarkModeOn: false);
//                     userProvider.setCurrentUser(givenCurrentUser: newUserData);
//                     switcher!.changeTheme(theme: AppTheme.lightTheme(),reverseAnimation: true);
//                   }
//                 });
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // class SettingsSwitchTile extends StatefulWidget {
// //   const SettingsSwitchTile({
// //     Key? key,
// //   }) : super(key: key);
// //
// //   @override
// //   _SettingsSwitchTileState createState() => _SettingsSwitchTileState();
// // }
// //
// // class _SettingsSwitchTileState extends State<SettingsSwitchTile> {
// //   var switchValue = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // final isDarkMode = Theme.of(context).brightness == Brightness.dark?true:false;
// //     return ThemeSwitcher(
// //       builder: (context) => SwitchListTile(
// //         title: Text(
// //           'Dark Mode',
// //           style: Theme.of(context).textTheme.subtitle1,
// //         ),
// //         subtitle: Text(
// //           'Change app theme(dark or light)',
// //           style: Theme.of(context).textTheme.bodyText2,
// //         ),
// //         value: switchValue,
// //         onChanged: (value) {
// //           // final theme = isDarkMode==true?AppTheme.darkTheme():AppTheme.lightTheme();
// //           final switcher = ThemeSwitcher.of(context);
// //
// //           setState(() {
// //             switchValue = value;
// //             if (value == true) {
// //               //switcher!.changeTheme(theme: AppTheme.darkTheme(),reverseAnimation: true);
// //               switcher!.changeTheme(theme: AppTheme.darkTheme());
// //             } else {
// //               //switcher!.changeTheme(theme: AppTheme.lightTheme(),reverseAnimation: true);
// //               switcher!.changeTheme(theme: AppTheme.lightTheme());
// //             }
// //           });
// //         },
// //         //tileColor: Colors.green,
// //         activeColor: Theme.of(context).primaryColor,
// //         inactiveTrackColor: Theme.of(context).accentColor.withOpacity(0.5),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
//
// // import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:social_app/app_theme.dart';
// // import 'package:social_app/providers/user_provider.dart';
// // import 'package:social_app/utils/user_preferences.dart';
// //
// // class SettingsPage extends StatelessWidget {
// //   static const routeName = '/settings-page';
// //
// //   const SettingsPage({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ThemeSwitchingArea(
// //       child: Builder(
// //         builder: (context) => Scaffold(
// //           appBar: AppBar(
// //             title: Text('Settings'),
// //           ),
// //           body: ListView(
// //             physics: BouncingScrollPhysics(),
// //             children: [
// //               //SettingsSwitchTile(),
// //               AppThemeSwitcher(),
// //
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class AppThemeSwitcher extends StatefulWidget {
// //   const AppThemeSwitcher({Key? key}) : super(key: key);
// //
// //   @override
// //   _AppThemeSwitcherState createState() => _AppThemeSwitcherState();
// // }
// //
// // class _AppThemeSwitcherState extends State<AppThemeSwitcher> {
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     //var switchValue = Theme.of(context).brightness == Brightness.dark?true:false;
// //     var user = UserPreferences.getUser();
// //     var switchValue = user.isDarkModeOn;
// //
// //     return ListTile(
// //       title: Text(
// //         'Dark Mode',
// //         style: Theme.of(context).textTheme.subtitle1,
// //       ),
// //       subtitle: Text(
// //         'Change app theme(dark or light)',
// //         style: Theme.of(context).textTheme.bodyText2,
// //       ),
// //       trailing: ThemeSwitcher(
// //         builder: (context)=>Consumer<UserProvider>(
// //           builder: (context,userProvider,child)=> Switch(
// //             activeColor: Theme.of(context).primaryColor,
// //             inactiveTrackColor: Theme.of(context).accentColor.withOpacity(0.5),
// //             activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.5),//Theme.of(context).primaryColor.withOpacity(0.5),
// //             value: switchValue,
// //             onChanged: (value) {
// //               final switcher = ThemeSwitcher.of(context);
// //               setState(() {
// //                 switchValue = value;
// //                 if (value == true) {
// //                   final newUser = user.copy(isDarkModeOn: true);
// //                   UserPreferences.setUser(newUser);
// //                   //switcher!.changeTheme(theme: AppTheme.darkTheme(),reverseAnimation: true);
// //                   switcher!.changeTheme(theme: AppTheme.darkTheme());
// //
// //                 } else {
// //                   final newUser = user.copy(isDarkModeOn: false);
// //                   UserPreferences.setUser(newUser);
// //                   switcher!.changeTheme(theme: AppTheme.lightTheme(),reverseAnimation: true);
// //                   //switcher!.changeTheme(theme: AppTheme.lightTheme());
// //                 }
// //               });
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // class SettingsSwitchTile extends StatefulWidget {
// // //   const SettingsSwitchTile({
// // //     Key? key,
// // //   }) : super(key: key);
// // //
// // //   @override
// // //   _SettingsSwitchTileState createState() => _SettingsSwitchTileState();
// // // }
// // //
// // // class _SettingsSwitchTileState extends State<SettingsSwitchTile> {
// // //   var switchValue = false;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // final isDarkMode = Theme.of(context).brightness == Brightness.dark?true:false;
// // //     return ThemeSwitcher(
// // //       builder: (context) => SwitchListTile(
// // //         title: Text(
// // //           'Dark Mode',
// // //           style: Theme.of(context).textTheme.subtitle1,
// // //         ),
// // //         subtitle: Text(
// // //           'Change app theme(dark or light)',
// // //           style: Theme.of(context).textTheme.bodyText2,
// // //         ),
// // //         value: switchValue,
// // //         onChanged: (value) {
// // //           // final theme = isDarkMode==true?AppTheme.darkTheme():AppTheme.lightTheme();
// // //           final switcher = ThemeSwitcher.of(context);
// // //
// // //           setState(() {
// // //             switchValue = value;
// // //             if (value == true) {
// // //               //switcher!.changeTheme(theme: AppTheme.darkTheme(),reverseAnimation: true);
// // //               switcher!.changeTheme(theme: AppTheme.darkTheme());
// // //             } else {
// // //               //switcher!.changeTheme(theme: AppTheme.lightTheme(),reverseAnimation: true);
// // //               switcher!.changeTheme(theme: AppTheme.lightTheme());
// // //             }
// // //           });
// // //         },
// // //         //tileColor: Colors.green,
// // //         activeColor: Theme.of(context).primaryColor,
// // //         inactiveTrackColor: Theme.of(context).accentColor.withOpacity(0.5),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
