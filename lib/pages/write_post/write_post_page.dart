import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/custom_dialog.dart';
import 'package:social_app/common_widgets/loading_dialog.dart';
import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/common_widgets/my_icon_button.dart';
import 'package:social_app/common_widgets/my_text_filed.dart';
import 'package:social_app/providers/post_provider.dart';
import 'package:social_app/providers/user_provider.dart';

import '../../../constants.dart';

class WritePostPage extends StatefulWidget {
  static const routeName = '/add-new-post-page';

  @override
  _WritePostPageState createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) => Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: MyIconButton(
                iconColor: appTheme.accentColor,
                onPressed: () {
                  postProvider.deleteUserPickedImage();
                  Navigator.pop(context);
                },
                svgIcon: SvgIcon.ArrowLeftCircle,
              ),
              title: Text('Add New Post'),
              actions: [
                postProvider.addNewPostLoading == false
                    ? MyIconButton(
                        svgIcon: SvgIcon.TickSquare,
                        iconColor: appTheme.primaryColor,
                        onPressed: () {
                          if (_controller.text.isEmpty &&
                              postProvider.pickedImage == null) {
                            buildCustomDialog(
                              context: context,
                              title: 'Can\'t share post',
                              subTitle:
                                  'Can not share an empty post!!\nPlease write some words or add an image.',
                            );
                          } else {
                            try {
                              postProvider.addNewPost(
                                createdAt: Timestamp.now(),
                                postContent: _controller.text,
                              );
                            } catch (error) {
                              buildCustomDialog(
                                context: context,
                                title: 'An error occurred!',
                                subTitle: error.toString(),
                              );
                            } finally {
                              postProvider.deleteUserPickedImage();
                              Navigator.pop(context);
                            }
                          }
                        },
                      )
                    : Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 24,
                          height: 24,
                          margin: EdgeInsets.all(KAppPadding),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: KAppPadding),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if (postProvider.addNewPostLoading == true)
                    //   Center(child: MyLoader()),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          userProvider.getCurrentUserData.imageUrl!,
                        ),
                      ),
                      title: Text(
                        userProvider.getCurrentUserData.name!,
                        //userData['name'], //
                        style: appTheme.textTheme.subtitle1,
                      ),
                      subtitle: Text(
                        '${DateTime.now().toString().substring(0, 10)}',
                        style: appTheme.textTheme.bodyText2,
                      ),
                    ),
                    MyTextFiled(
                      controller: _controller,
                      hintText: 'Write your post here...',
                      hPadding: 0.0,
                      maxLines: 10,
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            postProvider.pickImage();
                          },
                          icon: MyIcon(
                            color: appTheme.accentColor,
                            svgIcon: SvgIcon.Image,
                          ),
                          label: Text(
                            'Gallery',
                            style: appTheme.textTheme.bodyText1,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            showLoadingDialog(context);
                          },
                          icon: MyIcon(
                            color: appTheme.accentColor,
                            svgIcon: SvgIcon.Camera,
                          ),
                          label: Text(
                            'Camera',
                            style: appTheme.textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    if (postProvider.pickedImage != null)
                      FittedBox(
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.24,
                                child: Image.file(
                                  postProvider.pickedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.9),
                              child: InkWell(
                                onTap: () {
                                  print('delete image');
                                  postProvider.deleteUserPickedImage();
                                  // print('${appCubit.pickedImage}');
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class WritePostPage extends StatelessWidget {
//   static const routeName = '/write-post-page';
//   const WritePostPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('WritePostPage'),
//       ),
//     );
//   }
// }
