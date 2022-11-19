import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/error_widget.dart';
import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/common_widgets/my_icon_button.dart';
import 'package:social_app/common_widgets/my_loader.dart';
import 'package:social_app/pages/chat/userWidget.dart';
import 'package:social_app/providers/chat_provider.dart';

class ChatsPage extends StatelessWidget {
  final PageController? pageController;

  const ChatsPage({
    Key? key,
    this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyIconButton(
          svgIcon: SvgIcon.ArrowLeftCircle,
          onPressed: () {
            if (pageController != null) {
              pageController!.previousPage(
                duration: Duration(milliseconds: 750),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        title: Text('Chats'),
        actions: [
          MyIconButton(
            svgIcon: SvgIcon.MoreSquare,
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: Provider.of<ChatProvider>(context, listen: false)
                .getCurrentUserFriends(),
            builder: (BuildContext context, friendsSnapshot) {
              if (friendsSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: MyLoader());
              }
              if (friendsSnapshot.error != null) {
                return ErrorOccurredWidget();
              }
              return Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  var userFriends = chatProvider.userFriends;
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: userFriends.length,
                    itemBuilder: (context, index) => UserWidget(
                      user: userFriends[index],
                      lastMessage:
                          'this is the last message this is the last message',
                    ),
                  );
                },
              );
            },
          ),
          Divider(
            height: 0.0,
          ),
        ],
      ),
    );
  }
}
