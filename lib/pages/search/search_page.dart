import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/app_button.dart';
import 'package:social_app/common_widgets/my_text_filed.dart';
import 'package:social_app/common_widgets/show_lottie_image.dart';
import 'package:social_app/providers/story_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ShowLottieImage(
            lottieName: LottieName.search,
          ),
          // Expanded(
          //   child: ListView(),
          // ),

          MyTextFiled(
            controller: controller,
            hintText: 'story',
          ),
          AppButton(
            text: 'Share',
            onPressed: () {
              Provider.of<StoryProvider>(context,listen: false).saveNewStory(content: controller.text, createdAt: Timestamp.now());
            },
          ),
        ],
      ),
    );
  }
}
