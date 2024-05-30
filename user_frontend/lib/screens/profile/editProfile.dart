import 'package:flutter/material.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/customTextField1.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Menghindari perubahan tata letak saat keyboard muncul
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * 0.16,
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ), // Warna border bulatan
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: MediaQuery.of(context).size.height * 0.04,
              ),
              onTap: () {
                Navigator.pop(context); // Kembali ke menu sebelumnya
              },
            ),
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text(
          'Edit Profil',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.03,
          ),
        ),
        centerTitle: true,
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
                          style: TextStyle(fontSize: screenHeight * 0.024),
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
                          style: TextStyle(fontSize: screenHeight * 0.024),
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
                          style: TextStyle(fontSize: screenHeight * 0.024),
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
                      style: TextStyle(fontSize: screenHeight * 0.04),
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
                        backgroundColor: Colors.green,
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
