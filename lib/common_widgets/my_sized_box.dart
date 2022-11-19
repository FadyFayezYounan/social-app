import 'package:flutter/material.dart';

import '../constants.dart';

class MyHeightSizedBox extends StatelessWidget {
  const MyHeightSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: KAppPadding,
    );
  }
}
