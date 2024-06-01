import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarProfile extends StatelessWidget {
  final String title;

  const AppBarProfile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    return AppBar(
      toolbarHeight: sizeHeight,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: sizeHeight * 0.04,
        ),
      ),
      centerTitle: true, // Memusatkan judul
    );
  }
}
