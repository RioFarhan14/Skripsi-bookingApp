import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/fieldProvider.dart';
import 'package:user_frontend/providers/membershipProvider.dart';
import 'package:user_frontend/utils/customAppBar.dart';
import 'package:user_frontend/utils/customBotton1.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _selectedPaymentMethod;
  late dynamic product;
  late String quantity;
  late num total;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      final int id = args['id'];
      quantity = args['quantity'].toString(); // Ensure quantity is a String
      final bool isBooking = args['booking'];
      if (isBooking == true) {
        product = Provider.of<FieldProvider>(context, listen: false)
            .fields
            .firstWhere((fields) => fields.id == id);
      } else {
        product = Provider.of<MembershipProvider>(context, listen: false)
            .memberships
            .firstWhere((memberships) => memberships.id == id);
      }
      total = int.parse(quantity) * product.price; // Calculate total correctly
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: const CustomAppBar(title: 'Checkout'),
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
                      product.image,
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
                          product.name,
                          style:
                              GoogleFonts.poppins(fontSize: screenWidth * 0.05),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: quantity,
                                style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.04),
                              ),
                              TextSpan(
                                text: ' x ',
                                style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.04),
                              ),
                              TextSpan(
                                text: product.price
                                    .toString(), // Ensure price is a String
                                style: GoogleFonts.poppins(
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
                  style: GoogleFonts.poppins(fontSize: screenWidth * 0.055),
                ),
                Text(
                  total.toString(), // Ensure total is converted to String
                  style: GoogleFonts.poppins(fontSize: screenWidth * 0.055),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: const OutlineInputBorder(), // Add border here
                hintText: 'Metode Pembayaran',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.wallet,
                      ),
                      SizedBox(
                          width: screenWidth *
                              0.02), // Space between icon and text
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
