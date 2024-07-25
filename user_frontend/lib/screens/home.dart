import 'package:flutter/material.dart';
import 'package:user_frontend/widgets/buttonMenu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          SizedBox(
              height: screenHeight * 0.2,
              width: screenWidth * 0.9,
              child: Image.asset(
                'assets/images/homeImg.jpg',
                fit: BoxFit.fill,
              )),
          SizedBox(height: screenHeight * 0.02),
          Container(
            height: screenHeight * 0.40,
            width: screenWidth * 0.90,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 233, 233, 233),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonMenu(
                      imageAsset: 'assets/images/bookIcon.png',
                      text: 'Pesan Lapangan',
                      onPressed: () {
                        Navigator.pushNamed(context, '/booking');
                      },
                    ),
                    ButtonMenu(
                      imageAsset: 'assets/images/scheduleIcon.png',
                      text: 'Lihat Jadwal',
                      onPressed: () {
                        Navigator.pushNamed(context, '/viewSchedule');
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonMenu(
                      imageAsset: 'assets/images/help.png',
                      text: 'Bantuan',
                      onPressed: () {
                        Navigator.pushNamed(context, '/help');
                      },
                    ),
                    ButtonMenu(
                      imageAsset: 'assets/images/about.png',
                      text: 'Tentang Kami',
                      onPressed: () {
                        Navigator.pushNamed(context, '/aboutMe');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
