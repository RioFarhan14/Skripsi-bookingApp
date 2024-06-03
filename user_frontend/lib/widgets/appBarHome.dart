import 'package:flutter/material.dart';
import 'package:user_frontend/utils/theme.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final VoidCallback onNotificationPressed;

  const AppBarHome({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onNotificationPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final sizeHeight = constraints.maxHeight;
        final sizeWidth = constraints.maxWidth;

        return AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: sizeHeight * 0.9,
          backgroundColor: darkBlueColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: whiteTextStyle,
              ),
              SizedBox(
                height: sizeHeight * 0.08,
              ),
              Text(
                subtitle,
                style: whiteTextStyle,
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: sizeWidth * 0.04),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeWidth * 0.03),
                  color: whiteColor,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: sizeHeight * 0.2,
                    color: darkBlueColor,
                  ),
                  onPressed: onNotificationPressed,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
