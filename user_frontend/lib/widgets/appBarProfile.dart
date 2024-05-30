import 'package:flutter/material.dart';

class AppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarProfile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize:
              kToolbarHeight * 0.5, // Sesuaikan ukuran font sesuai kebutuhan
        ),
      ),
      centerTitle: true, // Memusatkan judul
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
