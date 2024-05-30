import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_frontend/utils/customBotton1.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: screenWidth * 0.16,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: screenHeight * 0.04,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        toolbarHeight: screenHeight * 0.1,
        title: Text(
          'Checkout',
          style: TextStyle(fontSize: screenHeight * 0.03),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
        padding: EdgeInsets.all(screenWidth * 0.07),
        width: screenWidth * 0.9,
        height: screenHeight * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.24,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020',
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.35,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lapangan A',
                          style: TextStyle(fontSize: screenWidth * 0.05),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '1 x ',
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                              TextSpan(
                                text: 'Rp.110.000,-',
                                style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Biaya',
                  style: TextStyle(fontSize: screenWidth * 0.055),
                ),
                Text(
                  'Rp.110.000,-',
                  style: TextStyle(fontSize: screenWidth * 0.055),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: const OutlineInputBorder(), // Tambahkan border di sini
                hintText: 'Metode Pembayaran',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.01,
                ),
              ),
              value: _selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue;
                });
              },
              items: <String>[
                'GoPay',
                'Dana',
                'Mandiri',
                'BCA',
              ].map<DropdownMenuItem<String>>((String value) {
                switch (value) {
                  case 'GoPay':
                    break;
                  case 'Dana':
                    break;
                  case 'Mandiri':
                    break;
                  case 'BCA':
                    break;
                  default:
                }
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.wallet),
                      SizedBox(
                          width:
                              screenWidth * 0.02), // Jarak antara icon dan teks
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            CustomButton1(
                title: 'Bayar',
                onPressed: () {},
                backgroundColor: Colors.green,
                colorText: Colors.white,
                buttonWidth: 0.8,
                buttonHeight: 0.065)
          ],
        ),
      ),
    );
  }
}
