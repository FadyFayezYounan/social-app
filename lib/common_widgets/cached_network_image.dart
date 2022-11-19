import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'my_icon.dart';
import 'my_sized_box.dart';


class MyCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;

  const MyCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius : 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // constraints: BoxConstraints(
      //   maxHeight: 50.h,
      // ),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12.0),
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          placeholder: (context, url) => Container(
            // color: Colors.grey,
            padding: EdgeInsets.all(KAppPadding * 2),
            child: MyIcon(
              svgIcon: SvgIcon.Camera,
              color: Theme.of(context).accentColor.withOpacity(0.5),
              size: 48.0,
            ),
          ),
          errorWidget: (context, url, error) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyIcon(
                svgIcon: SvgIcon.InfoSquare,
                color: Colors.redAccent,
                size: 48.0,
              ),
              MyHeightSizedBox(),
              Text(
                'Something Went Wrong!!',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
