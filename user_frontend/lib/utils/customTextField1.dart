import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField1 extends StatelessWidget {
  const CustomTextField1({
    Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    required this.fieldHeight,
    required this.fieldWidth,
    this.prefixIcon,
    this.fontSize,
    this.onTap,
    this.readOnly = false,
    this.enabled = true, // Tambahkan parameter enabled
    this.inputFormatters, // Tambahkan parameter inputFormatters
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final double fieldWidth;
  final double fieldHeight;
  final Function(String)? onChanged;
  final FaIcon? prefixIcon;
  final double? fontSize;
  final bool enabled; // Definisikan parameter enabled
  final VoidCallback? onTap;
  final bool readOnly;
  final List<TextInputFormatter>?
      inputFormatters; // Definisikan parameter inputFormatters

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * fieldHeight,
      width: screenWidth * fieldWidth,
      child: TextField(
        controller: controller,
        inputFormatters: inputFormatters, // Gunakan inputFormatters di sini
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,
        enabled: enabled, // Gunakan nilai parameter enabled
        style: TextStyle(fontSize: fontSize ?? screenHeight * 0.022),
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null
              ? Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: prefixIcon!,
                )
              : null,
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.01,
            horizontal: screenWidth * 0.04,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenHeight * 0.015),
              bottomRight: Radius.circular(screenHeight * 0.015),
            ),
          ),
        ),
      ),
    );
  }
}
