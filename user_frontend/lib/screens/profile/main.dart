import 'package:flutter/material.dart';
import 'package:user_frontend/screens/profile/editProfile.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/theme.dart';
import 'package:user_frontend/widgets/textProfile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/images/profile.png',
            width: screenWidth * 0.4,
            height: screenWidth * 0.4,
          ),
          SizedBox(height: screenHeight * 0.04),
          SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.24,
            child: Column(
              children: [
                const TextContainerProfile(
                  title: 'Nama',
                  field: 'Rio Farhan Avito',
                ),
                SizedBox(height: screenHeight * 0.02),
                const TextContainerProfile(
                  title: 'Username',
                  field: 'Riofarhan1',
                ),
                SizedBox(height: screenHeight * 0.02),
                const TextContainerProfile(
                  title: 'No Telepon',
                  field: '08XXXXXXXXX',
                ),
                SizedBox(height: screenHeight * 0.02),
                const TextContainerProfile(
                  title: 'Status Pengguna',
                  field: 'Membership',
                ),
              ],
            ),
          ),
          CustomButton1(
            buttonHeight: 0.06,
            buttonWidth: 0.7,
            title: 'Edit Profil',
            onPressed: () {
              // Navigasi ke halaman Edit Profile
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },
            backgroundColor: orangeColor,
            colorText: Colors.white,
          ),
          SizedBox(height: screenHeight * 0.01),
          CustomButton1(
            buttonHeight: 0.06,
            buttonWidth: 0.7,
            title: 'Logout',
            onPressed: () {},
            backgroundColor: Colors.red,
            colorText: Colors.white,
          ),
        ],
      ),
    );
  }
}
