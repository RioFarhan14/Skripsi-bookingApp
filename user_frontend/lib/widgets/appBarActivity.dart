import 'package:flutter/material.dart';

class AppBarActivity extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarActivity({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    return AppBar(
      toolbarHeight: sizeHeight * 0.09,
      backgroundColor: Colors.green[400],
      title: Text(
        title,
        style: TextStyle(fontSize: sizeHeight * 0.03),
      ),
      centerTitle: true, // Memusatkan judul
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
