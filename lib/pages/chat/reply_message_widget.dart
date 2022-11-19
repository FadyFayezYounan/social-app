import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/providers/chat_provider.dart';

import '../../constants.dart';

class ReplyMessageWidget extends StatelessWidget {
  final String content;
  final String receiverName;
  final Color? backgroundColor;
  final Color smallContainerColor;
  final bool inChatPage;

  //final String content;
  const ReplyMessageWidget({
    Key? key,
    required this.content,
    required this.receiverName,
    this.backgroundColor,
    this.inChatPage: false,
    required this.smallContainerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    var color = backgroundColor == null
        ? Colors.grey.withOpacity(0.1)
        : backgroundColor;
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12.0),
                  bottom:
                      inChatPage == true ? Radius.circular(12.0) : Radius.zero,
                ),
              ),
              padding: EdgeInsets.all(KAppPadding / 2),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    buildSmallColoredContainer(),
                    const SizedBox(
                      width: KAppPadding / 2,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: buildUserName(appTheme),
                              ),
                              if (inChatPage == false)
                                buildCloseReplyMessageButton(context, appTheme),
                            ],
                          ),
                          buildMessageContent(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (inChatPage == false)
            const SizedBox(
              width: KAppPadding / 2,
            ),
          if (inChatPage == false)
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
        ],
      ),
    );
  }

  Text buildUserName(ThemeData appTheme) {
    return Text(
      '$receiverName',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: appTheme.textTheme.bodyText1!.copyWith(
        fontWeight: FontWeight.w900,
      ),
    );
  }

  InkWell buildCloseReplyMessageButton(
      BuildContext context, ThemeData appTheme) {
    return InkWell(
      onTap: () {
        Provider.of<ChatProvider>(context, listen: false).deleteReplyMessage();
      },
      borderRadius: BorderRadius.circular(48.0),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: MyIcon(
          svgIcon: SvgIcon.CloseSquare,
          color: appTheme.accentColor.withOpacity(0.5),
        ),
      ),
    );
  }

  Text buildMessageContent() {
    return Text(
      content.isNotEmpty == true ? '$content' : 'Image',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
    );
  }

  Container buildSmallColoredContainer() {
    return Container(
      width: 5.0,
      decoration: BoxDecoration(
        color: smallContainerColor,
        borderRadius: BorderRadius.horizontal(
          //left: Radius.elliptical(16, 32),
          left: Radius.circular(32),
        ),
      ),
    );
  }
}
