import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/common_widgets/cached_network_image.dart';
import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/chat_message_model.dart';
import 'package:social_app/pages/chat/reply_message_widget.dart';
import 'package:social_app/providers/chat_provider.dart';

class MessageWidget extends StatelessWidget {
  final ChatMessageModel chatMessageModel;
  final String messageId;
  final String receiverImage;
  final String currentUser;
  final dynamic index;
  final ScrollController scrollController;

  //final ValueChanged<ChatMessageModel> onSwipedMessage;

  const MessageWidget({
    Key? key,
    required this.receiverImage,
    required this.currentUser,
    required this.messageId,
    //required this.onSwipedMessage,
    required this.chatMessageModel,
    required this.scrollController,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    var isSender = chatMessageModel.senderId == currentUser;
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return GestureDetector(
          onTap: (){
            scrollController.animateTo(3, duration: Duration(seconds: 1), curve: Curves.easeOut);
          },
          onLongPress: () {

            showModalBottomSheet(
                context: context,
                //elevation: 0.0,
                // backgroundColor: Colors.transparent,
                barrierColor: Colors.black26,
                builder: (ctx) {
                  return Container(
                    padding: EdgeInsets.all(KAppPadding / 2),
                    height: 12.h,
                    child: isSender == true
                        ? TextButton(
                            onPressed: () {
                              try {
                                chatProvider.deleteMessage(
                                  messageId: messageId,
                                  receiverId: chatMessageModel.receiverId!,
                                );
                                Navigator.pop(ctx);
                              } catch (error) {}
                            },
                            child: Column(
                              children: [
                                MyIcon(
                                  svgIcon: SvgIcon.Delete,
                                  color: Colors.redAccent,
                                ),
                                Text(
                                  'Delete',
                                  style: appTheme.textTheme.bodyText1!.copyWith(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.redAccent,
                            ),
                          )
                        : TextButton(
                            onPressed: () {},
                            child: Column(
                              children: [
                                MyIcon(
                                  svgIcon: SvgIcon.InfoSquare,
                                  color: Color(0xFFFDA900),
                                ),
                                Text(
                                  'Copy',
                                  style: appTheme.textTheme.bodyText1!.copyWith(
                                    color: Color(0xFFFDA900),
                                  ),
                                ),
                              ],
                            ),
                            style: TextButton.styleFrom(
                              primary: Color(0xFFFDA900),
                            ),
                          ),
                  );
                });
          },
          child: Column(
            crossAxisAlignment: isSender == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: isSender == true
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isSender == false)
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(receiverImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 4.w,
                    ),
                    chatMessageModel.content!.isNotEmpty == true
                        ? Container(
                            decoration: BoxDecoration(
                              color: isSender == true
                                  ? appTheme.primaryColor
                                  : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.only(
                                topLeft: isSender == false
                                    ? Radius.zero
                                    : Radius.circular(12.0),
                                topRight: isSender == true
                                    ? Radius.zero
                                    : Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                              ),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 6.0),
                            padding: const EdgeInsets.only(
                              top: 12.0,
                              bottom: 12.0,
                              left: 12.0,
                              right: 6.0,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: 76.w, //MediaQuery.of(context).size.width * 0.76,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (chatMessageModel.replyMessage != null)
                                  GestureDetector(
                                    onTap: (){
                                      //scrollController.animateTo(6, duration: Duration(seconds: 1), curve: Curves.easeOut);
                                      //scrollController.jumpTo(1);
                                    },
                                    child: ReplyMessageWidget(
                                      content: '${chatMessageModel.replyMessage!.content}',
                                      receiverName: '${chatMessageModel.replyMessage!.userName}',
                                      backgroundColor: Colors.white,
                                      inChatPage: true,
                                      smallContainerColor: isSender == true ?appTheme.accentColor : appTheme.primaryColor,
                                    ),
                                  ),
                                Text(
                                  '${chatMessageModel.content}',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: isSender == true
                                        ? Colors.white
                                        : appTheme.accentColor,
                                  ),
                                ),
                                Text(
                                  '${convertFromTimestampToTime(
                                      timestamp: chatMessageModel.createdAt!,
                                      timeFormat: TimeFormat.HoursMinutes)}',
                                  style: TextStyle(
                                    fontSize: 6.sp,
                                    color: isSender == true
                                        ? Colors.white
                                        : appTheme.accentColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 8.0,
                          ),
                  ],
                ),
              ),
              if (chatMessageModel.imageUrl != '')
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.w,
                    right: 4.w,
                    bottom: 8.0,
                    top: chatMessageModel.content!.isEmpty == true ? 8.0 : 0.0,
                  ),
                  child: MyCachedNetworkImage(
                    imageUrl: '${chatMessageModel.imageUrl}',
                    width: 76.w,
                    borderRadius: 12.0,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

//import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:social_app/common_widgets/cached_network_image.dart';
// import 'package:social_app/common_widgets/my_icon.dart';
// import 'package:social_app/common_widgets/my_modal_bottom_sheet.dart';
// import 'package:social_app/constants.dart';
// import 'package:social_app/models/chat_message_model.dart';
// import 'package:social_app/providers/chat_provider.dart';
//
// class MessageWidget extends StatelessWidget {
//   //final ChatMessageModel chatMessageModel;
//   final String messageId;
//   final String content;
//   final String receiverImage;
//   final String senderId;
//   final String currentUser;
//   final String receiverId;
//   final Timestamp createdAt;
//   final String imageUrl;
//
//   //final ValueChanged<ChatMessageModel> onSwipedMessage;
//
//   const MessageWidget({
//     Key? key,
//     required this.content,
//     required this.receiverImage,
//     required this.senderId,
//     required this.currentUser,
//     required this.receiverId,
//     required this.createdAt,
//     required this.imageUrl,
//     required this.messageId,
//     //required this.onSwipedMessage,
//     //required this.chatMessageModel,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var appTheme = Theme.of(context);
//     var isSender = senderId == currentUser;
//     return GestureDetector(
//       onLongPress: () {
//         showModalBottomSheet(
//             context: context,
//             //elevation: 0.0,
//             // backgroundColor: Colors.transparent,
//             barrierColor: Colors.black26,
//             builder: (ctx) {
//               return Container(
//                 padding: EdgeInsets.all(KAppPadding / 2),
//                 height: 12.h,
//                 child: isSender == true ? TextButton(
//                   onPressed: () {
//
//                      try{
//                        Provider.of<ChatProvider>(context, listen: false)
//                            .deleteMessage(
//                          messageId: messageId,
//                          receiverId: receiverId,
//                        );
//                        Navigator.pop(ctx);
//                      }catch(error){}
//
//                   },
//                   child: Column(
//                     children: [
//                       MyIcon(
//                         svgIcon: SvgIcon.Delete,
//                         color: Colors.redAccent,
//                       ),
//                       Text(
//                         'Delete',
//                         style: appTheme.textTheme.bodyText1!.copyWith(
//                           color: Colors.redAccent,
//                         ),
//                       ),
//                     ],
//                   ),
//                   style: TextButton.styleFrom(
//                     primary: Colors.redAccent,
//                   ),
//                 ) : TextButton(
//                   onPressed: () {
//
//                   },
//                   child: Column(
//                     children: [
//                       MyIcon(
//                         svgIcon: SvgIcon.InfoSquare,
//                         color: Color(0xFFFDA900),
//                       ),
//                       Text(
//                         'Copy',
//                         style: appTheme.textTheme.bodyText1!.copyWith(
//                           color: Color(0xFFFDA900),
//                         ),
//                       ),
//                     ],
//                   ),
//                   style: TextButton.styleFrom(
//                     primary: Color(0xFFFDA900),
//                   ),
//                 ),
//               );
//             });
//       },
//       child: Column(
//         crossAxisAlignment: isSender == true
//             ? CrossAxisAlignment.end
//             : CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 4.w),
//             child: Row(
//               mainAxisAlignment: isSender == true
//                   ? MainAxisAlignment.end
//                   : MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (isSender == false)
//                   Container(
//                     width: 8.w,
//                     height: 8.w,
//                     decoration: BoxDecoration(
//                       color: Colors.indigo,
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: NetworkImage(receiverImage),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 SizedBox(
//                   width: 4.w,
//                 ),
//                 content.isNotEmpty == true
//                     ? Container(
//                         decoration: BoxDecoration(
//                           color: isSender == true
//                               ? appTheme.primaryColor
//                               : Colors.grey.withOpacity(0.1),
//                           borderRadius: BorderRadius.only(
//                             topLeft: isSender == false
//                                 ? Radius.zero
//                                 : Radius.circular(12.0),
//                             topRight: isSender == true
//                                 ? Radius.zero
//                                 : Radius.circular(12.0),
//                             bottomLeft: Radius.circular(12.0),
//                             bottomRight: Radius.circular(12.0),
//                           ),
//                         ),
//                         margin: EdgeInsets.symmetric(vertical: 6.0),
//                         padding: const EdgeInsets.only(
//                           top: 12.0,
//                           bottom: 12.0,
//                           left: 12.0,
//                           right: 6.0,
//                         ),
//                         constraints: BoxConstraints(
//                           maxWidth:
//                               76.w, //MediaQuery.of(context).size.width * 0.76,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               content,
//                               style: TextStyle(
//                                 fontSize: 11.sp,
//                                 color: isSender == true
//                                     ? Colors.white
//                                     : appTheme.accentColor,
//                               ),
//                             ),
//                             Text(
//                               convertFromTimestampToTime(
//                                   timestamp: createdAt,
//                                   timeFormat: TimeFormat.HoursMinutes),
//                               style: TextStyle(
//                                 fontSize: 6.sp,
//                                 color: isSender == true
//                                     ? Colors.white
//                                     : appTheme.accentColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : SizedBox(
//                         height: 8.0,
//                       ),
//               ],
//             ),
//           ),
//           if (imageUrl != '')
//             Padding(
//               padding: EdgeInsets.only(
//                 left: 4.w,
//                 right: 4.w,
//                 bottom: 8.0,
//                 top: content.isEmpty == true ? 8.0 : 0.0,
//               ),
//               child: MyCachedNetworkImage(
//                 imageUrl: imageUrl,
//                 width: 76.w,
//                 borderRadius: 12.0,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
