import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserInfoWidget extends StatelessWidget {
  final String userName;
  final String userBio;
  final String userEmail;

  const UserInfoWidget({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.userBio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$userName',
          style: appTextTheme.headline6,
        ),
        SizedBox(
          height: 1.6.h,
        ),
        Text(
          '$userEmail',
          style: appTextTheme.bodyText2,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 1.6.h,
        ),
        Text(
          userBio.length==0?'Your Bio Should Be Here.':'$userBio',
          style: appTextTheme.bodyText2,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
