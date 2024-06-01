import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_frontend/utils/theme.dart';

class InkwellActivity extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const InkwellActivity({
    Key? key,
    required this.title,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      child: InkWell(
        onTap: onTap,
        splashColor: darkBlueColor, // Warna splash saat tombol ditekan
        highlightColor: Colors.transparent, // Menghilangkan highlight color
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? whiteColor : darkBlueColor,
            border: isActive
                ? Border(bottom: BorderSide(color: blackColor, width: 2))
                : null,
          ),
          width: screenWidth * 0.5,
          height: screenHeight * 0.08,
          alignment: Alignment.center, // Menempatkan teks di tengah-tengah
          child: Text(
            title,
            textAlign: TextAlign
                .center, // Untuk memastikan teks terpusat secara horizontal
            style: GoogleFonts.poppins(
              color: isActive
                  ? Colors.black
                  : Colors.white, // Mengubah warna teks saat aktif
            ),
          ),
        ),
      ),
    );
  }
}
