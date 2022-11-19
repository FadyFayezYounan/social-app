import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextFiledWidget extends StatefulWidget {
  final String leadingText;
  final String hintText;
  final String text;
  final ValueChanged<String> onChanged;
  final int maxLines;

  const TextFiledWidget({
    Key? key,
    required this.leadingText,
    required this.hintText,
    required this.text,
    required this.onChanged,
    this.maxLines : 1,
  }) : super(key: key);

  @override
  _TextFiledWidgetState createState() => _TextFiledWidgetState();
}

class _TextFiledWidgetState extends State<TextFiledWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 100.w,
      child: Row(
        children: [
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            flex: 1,
            child: Text(
              widget.leadingText,
              style: appTextTheme.bodyText2,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: appTextTheme.subtitle1!.copyWith(
                  fontSize: 14.sp,
                  color: Theme.of(context).accentColor.withOpacity(0.5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor.withOpacity(0.1),
                  ),
                ),
              ),
              style: appTextTheme.subtitle1!.copyWith(
                fontSize: 14.sp,
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
