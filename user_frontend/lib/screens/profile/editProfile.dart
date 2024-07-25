import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/authProvider.dart';
import 'package:user_frontend/utils/customAppBar.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/theme.dart';
import 'package:user_frontend/widgets/textButtonProfile.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final data = Provider.of<AuthProvider>(context).userData;
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Menghindari perubahan tata letak saat keyboard muncul
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.1),
        child: const CustomAppBar(title: 'Edit Profil'),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    screenHeight, // Setting tinggi minimum agar tidak terpengaruh oleh keyboard
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nama',
                          style: GoogleFonts.poppins(
                              fontSize: screenHeight * 0.024),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        TextButtonProfile(
                            name: data!['name'],
                            onPressed: () {
                              Navigator.pushNamed(context, '/form',
                                  arguments: 'name');
                            })
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Username',
                          style: GoogleFonts.poppins(
                              fontSize: screenHeight * 0.024),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        TextButtonProfile(
                            name: data['username'],
                            onPressed: () {
                              Navigator.pushNamed(context, '/form',
                                  arguments: 'username');
                            })
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'No telepon',
                          style: GoogleFonts.poppins(
                              fontSize: screenHeight * 0.024),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        TextButtonProfile(
                            name: data['user_phone'],
                            onPressed: () {
                              Navigator.pushNamed(context, '/form',
                                  arguments: 'user_phone');
                            })
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    CustomButton1(
                        buttonHeight: 0.07,
                        buttonWidth: 0.6,
                        title: 'Ganti Password',
                        // Within the `FirstRoute` widget
                        onPressed: () {
                          Navigator.pushNamed(context, '/form',
                              arguments: 'password');
                        },
                        backgroundColor: orangeColor,
                        colorText: Colors.white)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
