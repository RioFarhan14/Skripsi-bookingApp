import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton1 extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color colorText;
  final double buttonWidth;
  final double buttonHeight;
  const CustomButton1({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    required this.colorText,
    required this.buttonWidth,
    required this.buttonHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(
              screenWidth * buttonWidth,
              screenHeight *
                  buttonHeight), // Lebar 80% dan tinggi 6% dari layar
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final sizeHeight = constraints.maxHeight;
            return Text(
              title,
              style: GoogleFonts.poppins(
                color: colorText,
                fontSize: sizeHeight * 0.35,
              ),
            );
          },
        ),
      ),
    );
  }
}
