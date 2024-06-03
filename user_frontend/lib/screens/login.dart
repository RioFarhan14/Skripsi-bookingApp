import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/customTextField1.dart';
import 'package:user_frontend/utils/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darkBlueColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: screenWidth * 0.6,
              height: screenWidth * 0.6,
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            CustomTextField1(
              fieldHeight: 0.06,
              fieldWidth: 1,
              prefixIcon: FaIcon(
                FontAwesomeIcons.user,
                color: blackColor,
              ),
              backgroundColor: Colors.grey.shade200,
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            CustomTextField1(
              fieldHeight: 0.06,
              fieldWidth: 1,
              prefixIcon: FaIcon(
                FontAwesomeIcons.lock,
                color: blackColor,
              ),
              backgroundColor: Colors.grey.shade200,
            ),
            SizedBox(height: screenHeight * 0.08),
            CustomButton1(
                title: 'Masuk',
                onPressed: () {
                  Navigator.pushNamed(context, '/menuNavigation');
                },
                backgroundColor: orangeColor,
                colorText: whiteColor,
                buttonWidth: 1,
                buttonHeight: 0.06),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Text.rich(
              TextSpan(
                text: 'Belum punya akun ? ',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                children: [
                  TextSpan(
                    text: 'Daftar Sekarang !',
                    style: GoogleFonts.poppins(
                      color: orangeColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, '/register');
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
