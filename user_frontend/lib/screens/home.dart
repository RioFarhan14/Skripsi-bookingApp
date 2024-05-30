import 'package:flutter/material.dart';
import 'package:user_frontend/widgets/buttonMenu.dart';
import 'package:user_frontend/widgets/slideImage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

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
          const SlideImage(
              imageUrl: 'https://picsum.photos/seed/picsum/200/300'),
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
                      icon: Icons.sports_soccer,
                      text: 'Pesan Lapangan',
                      onPressed: () {
                        Navigator.pushNamed(context, '/booking');
                      },
                    ),
                    ButtonMenu(
                      icon: Icons.calendar_month_outlined,
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
                      icon: Icons.help,
                      text: 'Bantuan',
                      onPressed: () {
                        Navigator.pushNamed(context, '/help');
                      },
                    ),
                    ButtonMenu(
                      icon: Icons.info,
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
