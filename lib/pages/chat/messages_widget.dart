import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/common_widgets/my_sized_box.dart';
import 'package:social_app/models/chat_message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/providers/chat_provider.dart';
import 'package:social_app/providers/user_provider.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../constants.dart';
import 'message_widget.dart';
import 'package:sizer/sizer.dart';

class MessagesWidget extends StatelessWidget {


  final UserModel user;
  //final ValueChanged<ChatMessageModel> onSwipedMessage;
  const MessagesWidget({
    Key? key,
    required this.user,
    //required this.onSwipedMessage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Expanded(
      child: StreamBuilder(
        stream: Provider.of<ChatProvider>(context, listen: false)
            .listenToChats(
          receiverId: user.uId!,
        ),
        builder: (BuildContext context,
            AsyncSnapshot<dynamic> chatSnapshot) {
          if (chatSnapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var allChats = chatSnapshot.data.docs;

          if (allChats.length == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No messages yet!!'),
                MyHeightSizedBox(),
                MyIcon(
                  svgIcon: SvgIcon.Chat,
                  color:
                  Theme.of(context).accentColor.withOpacity(0.5),
                  size: 16.w,
                ),
              ],
            );
          }
          return Consumer<ChatProvider>(
            builder: (context,chatProvider,child){
              return GroupedListView<dynamic, String>(
                // indexedItemBuilder: (context , element , index){
                //   return SwipeTo(
                //     onRightSwipe: (){
                //       //onSwipedMessage(ChatMessageModel.fromJson(element));
                //       chatProvider.replayToMessage(ChatMessageModel.fromJson(element));
                //     },
                //     //animationDuration: Duration(milliseconds: 100),
                //     iconColor: Theme.of(context).accentColor,
                //     child: MessageWidget(
                //       chatMessageModel: ChatMessageModel.fromJson(element),  //chatProvider.convertFromSnapshotToChatMessageModel(element),
                //       messageId: element.id,
                //       currentUser: Provider.of<UserProvider>(context)
                //           .getCurrentUserData
                //           .uId!,
                //       receiverImage: user.imageUrl!,
                //       scrollController: scrollController,
                //     ),
                //   );
                // },
                controller: scrollController,
                padding: EdgeInsets.only(top: KAppPadding),
                physics: BouncingScrollPhysics(),
                elements: allChats,
                groupBy: (element) {
                  String createdAt = DateFormat.yMd().format(
                    DateTime.fromMicrosecondsSinceEpoch(
                        element['createdAt'].microsecondsSinceEpoch),
                  );
                  if (createdAt ==
                      DateFormat.yMd().format(DateTime.now())) {
                    createdAt = 'today';
                  }
                  return createdAt; //element['createdAt'].toString();
                },
                groupSeparatorBuilder: (String groupByValue) => Center(
                  child: Text(groupByValue),
                ),
                itemBuilder: (context, dynamic element){
                  return SwipeTo(
                    onRightSwipe: (){
                      //onSwipedMessage(ChatMessageModel.fromJson(element));
                      chatProvider.replayToMessage(ChatMessageModel.fromJson(element));
                    },
                    //animationDuration: Duration(milliseconds: 100),
                    iconColor: Theme.of(context).accentColor,
                    child: MessageWidget(
                      chatMessageModel: ChatMessageModel.fromJson(element),  //chatProvider.convertFromSnapshotToChatMessageModel(element),
                      messageId: element.id,
                      currentUser: Provider.of<UserProvider>(context)
                          .getCurrentUserData
                          .uId!,
                      receiverImage: user.imageUrl!,
                     scrollController: scrollController,
                    ),
                  );
                },
                ///////////////////
                // itemComparator: (item1, item2) =>
                //     item1['name'].compareTo(item2['name']),
                // optional
                useStickyGroupSeparators: false,
                // optional
                floatingHeader: true,
                // optional
                order: GroupedListOrder.DESC,
                reverse: true, // optional
              );
            },
          );
        },
      ),
    );
  }
}