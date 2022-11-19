import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void customLikesBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return makeDismissible(
          context: ctx,
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            maxChildSize: 0.9,
            minChildSize: 0.4,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  children: [
                    buildSmallContainer(),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
                              ),
                            ),
                            title: Text('user name ${index+1}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      });
}

Container buildSmallContainer() => Container(
      width: 12.w,
      height: 6.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(48.0),
      ),
    );

Widget makeDismissible({required Widget child, required BuildContext context}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      Navigator.pop(context);
    },
    child: GestureDetector(
      onTap: () {},
      child: child,
    ),
  );
}
