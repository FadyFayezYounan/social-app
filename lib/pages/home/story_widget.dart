import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
          ),
        ],
      ),
    );
  }
}
