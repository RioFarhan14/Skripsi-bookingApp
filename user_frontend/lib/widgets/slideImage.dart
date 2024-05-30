import 'package:flutter/material.dart';

class SlideImage extends StatelessWidget {
  final String imageUrl;

  const SlideImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(
        imageUrl,
        height: screenHeight * 0.20,
        width: screenWidth * 0.95,
        fit: BoxFit.cover,
      ),
    );
  }
}
