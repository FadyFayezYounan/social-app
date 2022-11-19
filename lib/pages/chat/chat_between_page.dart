import 'package:flutter/material.dart';

import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/common_widgets/my_icon_button.dart';

import 'package:social_app/models/chat_message_model.dart';
import 'package:social_app/models/user_model.dart';

import 'package:social_app/pages/chat/messages_widget.dart';
import 'package:social_app/pages/chat/send_message_widget.dart';

class ChatBetweenPage extends StatefulWidget {
  static const routeName = '/chat-between-page';

  const ChatBetweenPage({Key? key}) : super(key: key);

  @override
  _ChatBetweenPageState createState() => _ChatBetweenPageState();
}

class _ChatBetweenPageState extends State<ChatBetweenPage> {
  //late final FocusNode focusNode;
  late final focusNode;

  //ChatMessageModel? replyMessage;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        leading: MyIconButton(
          svgIcon: SvgIcon.ArrowLeftCircle,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.imageUrl!),
          ),
          title: Text(user.name!),
          subtitle: Text(
            'Active',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          trailing: MyIconButton(
            svgIcon: SvgIcon.MoreSquare,
            onPressed: () {},
          ),
        ),
        titleSpacing: 0.0,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              MessagesWidget(
                user: user,
              ),
              SendMessageWidget(
                receiverId: user.uId!,
                focusNode: focusNode,
              ),
            ],
          ),
          Divider(
            height: 0.0,
          ),
        ],
      ),
    );
  }


}

//
// import 'package:flutter/material.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:social_app/common_widgets/my_icon.dart';
// import 'package:social_app/common_widgets/my_icon_button.dart';
// import 'package:social_app/common_widgets/my_sized_box.dart';
// import 'package:social_app/constants.dart';
// import 'package:social_app/models/user_model.dart';
// import 'package:social_app/pages/chat/message_widget.dart';
// import 'package:social_app/pages/chat/send_message_widget.dart';
// import 'package:social_app/providers/chat_provider.dart';
// import 'package:social_app/providers/user_provider.dart';
// import 'package:sizer/sizer.dart';
//
//
// class ChatBetweenPage extends StatelessWidget {
//   static const routeName = '/chat-between-page';
//   const ChatBetweenPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var user = ModalRoute.of(context)!.settings.arguments as UserModel;
//     return Scaffold(
//       appBar: AppBar(
//         leading: MyIconButton(
//           svgIcon: SvgIcon.ArrowLeftCircle,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: ListTile(
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage(user.imageUrl),
//           ),
//           title: Text(user.name),
//           subtitle: Text(
//             'Active',
//             style: Theme.of(context).textTheme.bodyText2,
//           ),
//           trailing: MyIconButton(
//             svgIcon: SvgIcon.Message,
//             onPressed: () {},
//           ),
//         ),
//         titleSpacing: 0.0,
//       ),
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Column(
//             children: [
//               Expanded(
//                 child: StreamBuilder(
//                   stream: Provider.of<ChatProvider>(context, listen: false)
//                       .listenToChats(
//                     receiverId: user.uId,
//                   ),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<dynamic> chatSnapshot) {
//                     if (chatSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                     var allChats = chatSnapshot.data.docs;
//
//                     if (allChats.length == 0) {
//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('No messages yet!!'),
//                           MyHeightSizedBox(),
//                           MyIcon(
//                             svgIcon: SvgIcon.Comment,
//                             color:
//                             Theme.of(context).accentColor.withOpacity(0.5),
//                             size: 16.w,
//                           ),
//                         ],
//                       );
//                     }
//                     return GroupedListView<dynamic, String>(
//                       padding: EdgeInsets.only(top: KAppPadding),
//                       physics: BouncingScrollPhysics(),
//                       elements: allChats,
//                       groupBy: (element) {
//                         String createdAt = DateFormat.yMd().format(
//                           DateTime.fromMicrosecondsSinceEpoch(
//                               element['createdAt'].microsecondsSinceEpoch),
//                         );
//                         if (createdAt ==
//                             DateFormat.yMd().format(DateTime.now())) {
//                           createdAt = 'today';
//                         }
//                         return createdAt; //element['createdAt'].toString();
//                       },
//                       groupSeparatorBuilder: (String groupByValue) => Center(
//                         child: Text(groupByValue),
//                       ),
//                       itemBuilder: (context, dynamic element) => MessageWidget(
//                         content: element['content'],
//                         createdAt: element['createdAt'],
//                         senderId: element['senderId'],
//                         imageUrl: element['imageUrl'],
//                         currentUser: Provider.of<UserProvider>(context)
//                             .getCurrentUserData
//                             .uId,
//                         receiverImage: user.imageUrl,
//                       ),
//                       // itemComparator: (item1, item2) =>
//                       //     item1['name'].compareTo(item2['name']),
//                       // optional
//                       useStickyGroupSeparators: false,
//                       // optional
//                       floatingHeader: true,
//                       // optional
//                       //order: GroupedListOrder.DESC,
//                       reverse: true, // optional
//                     );
//                   },
//                 ),
//               ),
//               SendMessageWidget(receiverId: user.uId),
//             ],
//           ),
//           Divider(
//             height: 0.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
