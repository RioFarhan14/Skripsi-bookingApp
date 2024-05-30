import 'package:flutter/material.dart';

class ButtonMenu extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const ButtonMenu({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menggunakan MediaQuery untuk mendapatkan ukuran layar
    final height = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: SizedBox(
        width: height * 0.15, // Menggunakan tinggi layar sebagai referensi
        height: height * 0.15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: height * 0.09,
              color: Colors.black,
            ),
            SizedBox(height: height * 0.01),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
