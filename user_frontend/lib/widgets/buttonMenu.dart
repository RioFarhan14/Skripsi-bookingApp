import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonMenu extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String imageAsset;

  const ButtonMenu(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.imageAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menggunakan MediaQuery untuk mendapatkan ukuran layar
    final screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: SizedBox(
        width: screenHeight * 0.15,
        height: screenHeight * 0.15,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final sizeHeight = constraints.maxHeight;
            final sizeWidth = constraints.maxWidth;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageAsset,
                  height: sizeHeight * 0.5,
                ),
                SizedBox(height: sizeHeight * 0.1),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontSize: sizeWidth * 0.1),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
