import 'package:flutter/material.dart';
import 'package:social_app/common_widgets/my_icon.dart';
import 'package:social_app/common_widgets/show_lottie_image.dart';

import '../../constants.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    //String? dropdownValue;
    var appTheme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          ShowLottieImage(
            lottieName: LottieName.love,
          ),
          PopupMenuButton<String>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(KAppPadding),
            ),
            child: MyIcon(
              color: appTheme.accentColor,
              svgIcon: SvgIcon.MoreSquare,
            ),
            color: appTheme.scaffoldBackgroundColor,
            //offset: Offset(-32,-32),
            onSelected: (selectedValue) {
              switch (selectedValue) {
                case TextMenu.edit:
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Edit'),
                  ));
                  break;
                case TextMenu.share:
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Share'),
                  ));
                  break;
                case TextMenu.report:
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Report'),
                  ));
                  break;
              }
            },
            itemBuilder: (context) => TextMenu.items
                .map(
                  (element) => PopupMenuItem<String>(
                    value: element,
                    child: Text(element),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}

class TextMenu {
  static const items = [
    edit,
    share,
    report,
  ];
  static const String edit = 'Edit';
  static const String share = 'Share';
  static const String report = 'Report';
}
