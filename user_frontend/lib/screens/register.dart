import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/authProvider.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/customTextField1.dart';
import 'package:user_frontend/utils/theme.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: darkBlueColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Daftar',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.1, color: whiteColor),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Mohon lengkapi informasi berikut untuk mendaftar.',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.032, color: whiteColor),
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  'Nama',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.05, color: whiteColor),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField1(
                  fieldHeight: 0.06,
                  fieldWidth: 1,
                  controller: nameController,
                  backgroundColor: Colors.grey.shade300,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Username',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.05, color: whiteColor),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField1(
                  fieldHeight: 0.06,
                  fieldWidth: 1,
                  controller: usernameController,
                  backgroundColor: Colors.grey.shade300,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Password',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.05, color: whiteColor),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField1(
                  fieldHeight: 0.06,
                  fieldWidth: 1,
                  controller: passwordController,
                  obscureText: true,
                  backgroundColor: Colors.grey.shade300,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Konfirmasi Password',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.05, color: whiteColor),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField1(
                  fieldHeight: 0.06,
                  fieldWidth: 1,
                  controller: confirmPasswordController,
                  obscureText: true,
                  backgroundColor: Colors.grey.shade300,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'No Telepon',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.05, color: whiteColor),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField1(
                  fieldHeight: 0.06,
                  fieldWidth: 1,
                  controller: phoneController,
                  backgroundColor: Colors.grey.shade300,
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomButton1(
                  title: 'Daftar',
                  onPressed: () async {
                    try {
                      await authProvider.register(
                        usernameController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                        nameController.text,
                        phoneController.text,
                      );
                      Navigator.pushNamed(context, '/login');
                    } catch (error) {
                      // Handle registration error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Registration failed: $error'),
                        ),
                      );
                    }
                  },
                  backgroundColor: orangeColor,
                  colorText: whiteColor,
                  buttonWidth: 1,
                  buttonHeight: 0.07,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
