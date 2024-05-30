import 'package:flutter/material.dart';

class TextContainerProfile extends StatelessWidget {
  final String title;
  final String field;

  const TextContainerProfile({
    Key? key,
    required this.title,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: screenHeight * 0.023),
        ),
        Text(
          field,
          style: TextStyle(fontSize: screenHeight * 0.023),
        ),
      ],
    );
  }
}
