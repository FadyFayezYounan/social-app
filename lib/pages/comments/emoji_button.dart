import 'package:flutter/material.dart';

import '../../constants.dart';

class EmojiButton extends StatelessWidget {
  final TextEditingController controller;
  final String emojiName;

  const EmojiButton({
    Key? key,
    required this.controller,
    required this.emojiName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(48.0),
        onTap: () {
          controller.text = controller.text + emojiName;
        },
        child: Padding(
          padding: const EdgeInsets.all(KAppPadding / 2),
          child: Text(
            emojiName,
            style: TextStyle(
              fontSize: 16,
              color: Colors.yellow,
            ),
          ),
        ),
      ),
    );
  }
}