import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/common_widgets/my_icon_button.dart';
import 'package:social_app/pages/chat/reply_message_widget.dart';
import 'package:social_app/providers/chat_provider.dart';
import '../../constants.dart';
import 'package:sizer/sizer.dart';

class SendMessageWidget extends StatefulWidget {
  final String receiverId;

  final FocusNode focusNode;

  const SendMessageWidget({
    Key? key,
    required this.receiverId,
    required this.focusNode,
  }) : super(key: key);

  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) => Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          //color: Color(0xFF1D1C21),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(KAppPadding),
            topLeft: Radius.circular(KAppPadding),
            // bottomRight: Radius.circular(24.0),
            // bottomLeft: Radius.circular(24.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            if (chatProvider.pickedImage != null)
              FittedBox(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(KAppPadding / 2),
                      child: SizedBox(
                        height: 16.h,
                        child: Image.file(
                          chatProvider.pickedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 8.sp,
                      backgroundColor: Colors.redAccent.withOpacity(0.9),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(48.0),
                          onTap: () {
                            print('delete image');
                            chatProvider.deleteUserPickedImage();
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (chatProvider.replyMessage != null)
              ReplyMessageWidget(
                content: '${chatProvider.replyMessage!.content}',
                receiverName: '${chatProvider.replyMessage!.userName}',
                smallContainerColor: Theme.of(context).primaryColor,
              ),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.vertical(
                        top: chatProvider.replyMessage == null
                            ? Radius.circular(48.0)
                            : Radius.zero,
                        bottom: chatProvider.replyMessage == null
                            ? Radius.circular(48.0)
                            : Radius.circular(12.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: MyIconButton(
                            //iconColor: Colors.white,
                            onPressed: () {
                              chatProvider.pickImage();
                            },
                            svgIcon: SvgIcon.PaperPlus,
                            splashRadius: KAppPadding,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            focusNode: widget.focusNode,
                            controller: controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tap a message...',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5),
                                fontSize: 12.sp,
                              ),
                            ),
                            maxLines: 1,
                            style: TextStyle(
                              //color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: KAppPadding / 2,
                ),
                Expanded(
                  flex: 1,
                  child: chatProvider.loading == false
                      ? RawMaterialButton(
                          onPressed: () {
                            if (controller.text.trim().isEmpty &&
                                chatProvider.pickedImage == null) {
                              // do some thing...
                            } else {
                              chatProvider.sendMessage(
                                receiverId: widget.receiverId,
                                content: controller.text,
                                createdAt: Timestamp.now(),
                                replyMessage: chatProvider.replyMessage,
                              );
                              controller.clear();
                              chatProvider.deleteReplyMessage();
                              chatProvider.deleteUserPickedImage();
                            }
                          },
                          child: MyIcon(
                            svgIcon: SvgIcon.Send,
                            color: Colors.white,
                          ),
                          shape: StadiumBorder(),
                          fillColor: Theme.of(context).accentColor,
                          elevation: 0.0,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.sp, horizontal: 12.sp),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).accentColor,
                            strokeWidth: 1.6,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:social_app/common_widgets/my_icon.dart';
// import 'package:social_app/common_widgets/my_icon_button.dart';
// import 'package:social_app/providers/chat_provider.dart';
// import '../../constants.dart';
// import 'package:sizer/sizer.dart';
//
// class SendMessageWidget extends StatefulWidget {
//   final String receiverId;
//
//   const SendMessageWidget({
//     Key? key,
//     required this.receiverId,
//   }) : super(key: key);
//
//   @override
//   _SendMessageWidgetState createState() => _SendMessageWidgetState();
// }
//
// class _SendMessageWidgetState extends State<SendMessageWidget> {
//   late TextEditingController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChatProvider>(
//       builder: (context, chatProvider, child) => Container(
//         padding: const EdgeInsets.all(8.0),
//         decoration: BoxDecoration(
//           //color: Color(0xFF1D1C21),
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(KAppPadding),
//             topLeft: Radius.circular(KAppPadding),
//             // bottomRight: Radius.circular(24.0),
//             // bottomLeft: Radius.circular(24.0),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Divider(),
//             if (chatProvider.pickedImage != null)
//               FittedBox(
//                 child: Stack(
//                   alignment: Alignment.topRight,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(KAppPadding / 2),
//                       child: SizedBox(
//                         height: 16.h,
//                         child: Image.file(
//                           chatProvider.pickedImage!,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     CircleAvatar(
//                       radius: 8.sp,
//                       backgroundColor: Colors.redAccent.withOpacity(0.9),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(48.0),
//                           onTap: () {
//                             print('delete image');
//                             chatProvider.deleteUserPickedImage();
//                           },
//                           child: Icon(
//                             Icons.close,
//                             color: Colors.white,
//                             size: 12.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 6,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(48.0),
//                     ),
//                     child: Row(
//                       children: [
//                         Material(
//                           color: Colors.transparent,
//                           child: MyIconButton(
//                             //iconColor: Colors.white,
//                             onPressed: () {
//                               chatProvider.pickImage();
//                             },
//                             svgIcon: SvgIcon.PaperPlus,
//                             splashRadius: KAppPadding,
//                           ),
//                         ),
//                         Expanded(
//                           child: TextFormField(
//                             controller: controller,
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: 'Tap a message...',
//                               hintStyle: TextStyle(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//                             maxLines: 1,
//                             style: TextStyle(
//                               //color: Colors.white,
//                               fontSize: 12.sp,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: KAppPadding / 2,
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: chatProvider.loading == false
//                       ? RawMaterialButton(
//                           onPressed: () {
//                             if (controller.text.trim().isEmpty &&
//                                 chatProvider.pickedImage == null) {
//                               // do some thing...
//                             } else {
//                               chatProvider.sendMessage(
//                                   receiverId: widget.receiverId,
//                                   content: controller.text,
//                                   createdAt: Timestamp.now());
//                               controller.clear();
//                               chatProvider.deleteUserPickedImage();
//                             }
//                           },
//                           child: MyIcon(
//                             svgIcon: SvgIcon.Send,
//                             color: Colors.white,
//                           ),
//                           shape: StadiumBorder(),
//                           fillColor: Theme.of(context).accentColor,
//                           elevation: 0.0,
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10.sp, horizontal: 12.sp),
//                         )
//                       : Center(
//                           child: CircularProgressIndicator(
//                             color: Theme.of(context).accentColor,
//                             strokeWidth: 1.6,
//                           ),
//                         ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
