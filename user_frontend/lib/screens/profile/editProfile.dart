import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_frontend/utils/customAppBar.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/customTextField1.dart';
import 'package:user_frontend/utils/theme.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
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
                        SizedBox(
                            width: screenWidth *
                                0.6, // Sesuaikan dengan lebar yang diinginkan
                            child: const CustomTextField1(
                              keyboardType: TextInputType.name,
                              fieldHeight: 0.07,
                              fieldWidth: 0.7,
                            )),
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
                        SizedBox(
                            width: screenWidth *
                                0.6, // Sesuaikan dengan lebar yang diinginkan
                            child: const CustomTextField1(
                              keyboardType: TextInputType.name,
                              fieldHeight: 0.07,
                              fieldWidth: 0.7,
                            )),
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
                        SizedBox(
                            width: screenWidth *
                                0.6, // Sesuaikan dengan lebar yang diinginkan
                            child: const CustomTextField1(
                              keyboardType: TextInputType.phone,
                              fieldHeight: 0.07,
                              fieldWidth: 0.7,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      'Konfirmasi Password',
                      style: GoogleFonts.poppins(fontSize: screenHeight * 0.04),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    const CustomTextField1(
                      fieldHeight: 0.07,
                      fieldWidth: 0.7,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    CustomButton1(
                        buttonHeight: 0.07,
                        buttonWidth: 0.35,
                        title: 'Simpan',
                        // Within the `FirstRoute` widget
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false);
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
