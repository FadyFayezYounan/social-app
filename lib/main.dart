import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/app_theme.dart';
import 'package:social_app/page_routes.dart';
import 'package:social_app/pages/home/home_page.dart';
import 'package:social_app/pages/log_in/log_in_page.dart';
import 'package:social_app/pages/splash_page/splash_page.dart';
import 'package:social_app/providers/auth_provider.dart';
import 'package:social_app/providers/chat_provider.dart';
import 'package:social_app/providers/comment_provider.dart';
import 'package:social_app/providers/post_provider.dart';
import 'package:social_app/providers/story_provider.dart';
import 'package:social_app/providers/user_provider.dart';
import 'package:social_app/utils/user_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();
    runApp(
      Phoenix(
        child: MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final user = UserPreferences.getUser(userKey: KUserKey);

    return Sizer(
      builder: (context, orientation, deviceType) => ThemeProvider(
        initTheme: false //user.isDarkModeOn == true
            ? AppTheme.darkTheme()
            : AppTheme.lightTheme(),
        child: Builder(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: UserProvider()),
              ChangeNotifierProvider.value(value: AuthProvider()),
              ChangeNotifierProvider.value(value: PostProvider()),
              ChangeNotifierProvider.value(value: CommentProvider()),
              ChangeNotifierProvider.value(value: ChatProvider()),
              ChangeNotifierProvider.value(value: StoryProvider()),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeProvider.of(context),
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SplashPage();
                  }
                  if (snapshot.hasData == true) {
                    return HomePage();
                  }
                  return LogInPage();
                },
              ),
              routes: pageRoutes,
            ),
          ),
        ),
      ),
    );
  }
}

// class RestartWidget extends StatefulWidget {
//   final Widget child;
//
//   RestartWidget({required this.child});
//
//   static void restartApp(BuildContext context) {
//     context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
//   }
//
//   @override
//   _RestartWidgetState createState() => _RestartWidgetState();
// }
//
// class _RestartWidgetState extends State<RestartWidget> {
//   Key key = UniqueKey();
//
//   void restartApp() {
//     setState(() {
//       key = UniqueKey();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return KeyedSubtree(
//       key: key,
//       child: widget.child,
//     );
//   }
// }
