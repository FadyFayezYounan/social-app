import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/common_widgets/my_icon_button.dart';
import 'package:social_app/pages/chat/chats_page.dart';
import 'package:social_app/pages/favorites/favorites_page.dart';
import 'package:social_app/pages/posts/posts_page.dart';
import 'package:social_app/pages/profile/profile_page.dart';
import 'package:social_app/pages/search/search_page.dart';
import 'package:social_app/pages/write_post/write_post_page.dart';
import 'package:social_app/providers/user_provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PageController _pageController;



  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List pages = [
      PostsPage(),
      SearchPage(),
      WritePostPage(),
      FavoritesPage(),
      ProfilePage(),
    ];

    var appTheme = Theme.of(context);

    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        var currentIndex = userProvider.currentIndex;
        return PageView(
          controller: _pageController,
         children: [
           Scaffold(
             appBar: AppBar(
               title: Text('Home'),
               leading: MyIconButton(
                 svgIcon: SvgIcon.Category,
                 onPressed: () {},
               ),
               actions: [
                 MyIconButton(
                   svgIcon: SvgIcon.Notification,
                   onPressed: () {},
                 ),
               ],
             ),
             body: pages[currentIndex],
             bottomNavigationBar: buildBottomNavigationBar(
                 currentIndex, appTheme, userProvider, context),
           ),
           ChatsPage(pageController: _pageController,),
         ],
        );
      },
    );
  }

  BottomNavigationBar buildBottomNavigationBar(int currentIndex,
      ThemeData appTheme, UserProvider userProvider, BuildContext context) {
    return BottomNavigationBar(
      //elevation: 0.0,
      items: [
        BottomNavigationBarItem(
          icon: MyIcon(
            svgIcon: SvgIcon.Home,
            color: currentIndex == 0
                ? appTheme.primaryColor
                : appTheme.accentColor,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            svgIcon: SvgIcon.Search,
            color: currentIndex == 1
                ? appTheme.primaryColor
                : appTheme.accentColor,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            svgIcon: SvgIcon.Plus,
            color: currentIndex == 2
                ? appTheme.primaryColor
                : appTheme.accentColor,
          ),
          label: 'Write Post',
        ),
        BottomNavigationBarItem(
          icon: MyIcon(
            svgIcon: SvgIcon.Heart2,
            color: currentIndex == 3
                ? appTheme.primaryColor
                : appTheme.accentColor,
          ),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 12,
            backgroundImage:
                NetworkImage(userProvider.getCurrentUserData.imageUrl!),
          ),
          label: '${userProvider.getCurrentUserData.name}',
        ),
      ],
      currentIndex: userProvider.currentIndex,
      onTap: (int currentIndex) {
        if (currentIndex != 2) {
          userProvider.changeCurrentIndexValue(currentIndex);
        } else {
          Navigator.pushNamed(context, WritePostPage.routeName);
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      //showSelectedLabels: userProvider.currentIndex == 4 ?false:true,
      backgroundColor: appTheme.scaffoldBackgroundColor,
    );
  }
}
