import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/common_widgets/app_button.dart';
import 'package:social_app/common_widgets/my_outlined_button.dart';

import '../constants.dart';
import 'my_icon.dart';
import 'package:sizer/sizer.dart';

void myModalBottomSheet({
  required BuildContext context,
  required bool isCreator,
  required String userName,
  required VoidCallback deleteButtonPressed,
  required VoidCallback sendMessageButtonPressed,
}) {
  showModalBottomSheet(
      context: context,
      barrierColor: Colors.black26,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(32.0),
      // ),
      backgroundColor: Colors.black.withOpacity(0.01),
      builder: (ctx) {
        return Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(KAppPadding),
          ),
          margin: const EdgeInsets.all(KAppPadding),
          padding: EdgeInsets.all(KAppPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12.w,
                height: 6.0,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(48.0),
                ),
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    if (isCreator == true)
                      ModalBottomSheetDeleteButton(
                        text: 'Delete post',
                        leadingIcon: SvgIcon.Delete,
                        onPressed: () async {
                          deleteButtonPressed();
                          Navigator.pop(ctx);
                        },
                        iconColor: Color(0xFFE57373),
                      ),
                    if (isCreator == true)
                      ModalBottomSheetItem(
                        text: 'Edit post',
                        leadingIcon: SvgIcon.EditSquare,
                        onPressed: () {},
                        iconColor: Color(0xFFFDA900),
                      ),
                    ModalBottomSheetItem(
                      text: 'Save this post',
                      leadingIcon: SvgIcon.Bookmark,
                      onPressed: () {},
                      iconColor: Colors.teal,
                    ),
                    ModalBottomSheetItem(
                      text: 'Share this post',
                      leadingIcon: SvgIcon.Send,
                      onPressed: () {},
                      iconColor: Colors.indigo,
                    ),
                    if (isCreator == false)
                      ModalBottomSheetItem(
                        text: 'Send a Message to $userName',
                        leadingIcon: SvgIcon.Message,
                        onPressed: sendMessageButtonPressed,
                        iconColor: Colors.lightBlue,
                      ),
                    if (isCreator == false)
                      ModalBottomSheetItem(
                        text: 'Report this post',
                        leadingIcon: SvgIcon.InfoSquare,
                        onPressed: () {},
                        iconColor: Colors.redAccent,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

class ModalBottomSheetDeleteButton extends StatefulWidget {
  final String text;
  final SvgIcon leadingIcon;
  final Color iconColor;
  final VoidCallback onPressed;

  const ModalBottomSheetDeleteButton({
    Key? key,
    required this.text,
    required this.leadingIcon,
    required this.iconColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ModalBottomSheetDeleteButtonState createState() =>
      _ModalBottomSheetDeleteButtonState();
}

class _ModalBottomSheetDeleteButtonState
    extends State<ModalBottomSheetDeleteButton> {
  bool showFirst = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: showFirst == true
            ? () {
                setState(() {
                  showFirst = false;
                });
              }
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KAppPadding),
        ),
        leading: MyIcon(
          svgIcon: widget.leadingIcon,
          color: widget.iconColor, //Color(0xFFE57373)
        ),
        title: AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          crossFadeState: showFirst == true
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Text(
            widget.text,
            style: appTheme.textTheme.subtitle1!.copyWith(
              fontSize: 16.0,
            ),
          ),
          secondChild: Text(
            'Are you sure?',
            style: appTheme.textTheme.subtitle1!.copyWith(
              fontSize: 16.0,
            ),
          ),
          // firstCurve: Curves.easeIn,
          // secondCurve: Curves.easeOut,
        ),
        subtitle: showFirst == false
            ? Row(
                children: [
                  SizedBox(
                    width: KAppPadding,
                  ),
                  Expanded(
                    child: MyOutlinedButton(
                      onPressed: () {
                        setState(() {
                          showFirst = true;
                        });
                      },
                      text: 'no',
                      buttonHeight: 5,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: KAppPadding,
                  ),
                  Expanded(
                    child: AppButton(
                      onPressed: () async{
                        setState(() {
                          _isLoading = true;
                        });
                        try{
                           widget.onPressed();
                          setState(() {
                            _isLoading = false;
                          });
                        }catch(error){

                        }finally{
                          setState(() {
                            showFirst = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  MyIcon(
                                    svgIcon: SvgIcon.InfoSquare,
                                    color: Colors.white,
                                  ),
                                  const Text(
                                    '  Post deleted successfully!!',
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      text: 'yes',
                      vPadding: 0.0,
                      hPadding: 0.0,
                      borderRadius: 48.0,
                      buttonHeight: 5,
                      buttonWidth: 0.0,
                      fontSize: 12,
                      loading: _isLoading,
                    ),
                  ),
                  SizedBox(
                    width: KAppPadding,
                  ),
                ],
              )
            : null,
      ),
    );
  }
}

class ModalBottomSheetItem extends StatelessWidget {
  final String text;
  final SvgIcon leadingIcon;
  final Color iconColor;
  final VoidCallback onPressed;

  const ModalBottomSheetItem({
    Key? key,
    required this.text,
    required this.leadingIcon,
    required this.iconColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KAppPadding),
        ),
        leading: MyIcon(
          svgIcon: leadingIcon,
          color: iconColor, //Color(0xFFE57373)
        ),
        title: Text(
          text,
          style: appTheme.textTheme.subtitle1!.copyWith(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
