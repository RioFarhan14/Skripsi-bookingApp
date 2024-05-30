import 'package:flutter/material.dart';

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
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    return AppBar(
      toolbarHeight: sizeHeight * 0.09,
      backgroundColor: Colors.green[400],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize:
                    sizeHeight * 0.03), // Responsif berdasarkan tinggi layar
          ),
          SizedBox(
              height: sizeHeight * 0.01), // Responsif berdasarkan tinggi layar
          Text(
            subtitle,
            style: TextStyle(
                fontSize:
                    sizeHeight * 0.025), // Responsif berdasarkan tinggi layar
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
              right: sizeWidth * 0.04), // Responsif berdasarkan lebar layar
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(sizeWidth * 0.03),
              color: Colors.grey[200],
            ),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                size: sizeHeight * 0.03, // Responsif berdasarkan tinggi layar
              ),
              onPressed: onNotificationPressed,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
