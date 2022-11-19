import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/chat/chat_between_page.dart';

class UserWidget extends StatelessWidget {
  // final String userImage;
  // final String userName;
  final UserModel user;
  final String? lastMessage;

  //final String userName;
  const UserWidget({
    Key? key,
    required this.user,
    // required this.userName,
    // required this.userImage,
    this.lastMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.pushNamed(context, ChatBetweenPage.routeName,arguments: user);
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.imageUrl!),
      ),
      title: Text(user.name!),
      subtitle: lastMessage != null
          ? Text(
              lastMessage!,
              style: Theme.of(context).textTheme.bodyText2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: Text(
        '8h ago',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 9.sp,
        ),
      ),
    );
  }
}
