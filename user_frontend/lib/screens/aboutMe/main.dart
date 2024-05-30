import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: sizeWidth * 0.16,
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizeWidth * 0.02,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: sizeHeight * 0.04,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        toolbarHeight: sizeHeight * 0.1,
        title: Text(
          'Tentang Kami',
          style: TextStyle(fontSize: sizeWidth * 0.07),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeHeight * 0.2,
          )
        ],
      ),
    );
  }
}
