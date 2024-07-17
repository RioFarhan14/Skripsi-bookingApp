import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/models/field.dart';
import 'package:user_frontend/providers/productProvider.dart';
import 'package:user_frontend/utils/alert.dart';
import 'package:user_frontend/utils/constants.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/customTextField1.dart';
import 'package:user_frontend/utils/theme.dart';
import 'package:user_frontend/utils/timeUtils.dart';

class DetailBookingPage extends StatefulWidget {
  const DetailBookingPage({Key? key}) : super(key: key);

  @override
  State<DetailBookingPage> createState() => _DetailBookingPageState();
}

class _DetailBookingPageState extends State<DetailBookingPage> {
  late TextEditingController textDate;
  late TextEditingController textTime;
  late TextEditingController textDuration;
  late int fieldId;
  late Field field;

  @override
  void initState() {
    super.initState();
    textDate = TextEditingController();
    textTime = TextEditingController();
    textDuration = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fieldId = ModalRoute.of(context)!.settings.arguments as int;
    field = Provider.of<ProductProvider>(context, listen: false)
        .fields
        .firstWhere((field) => field.id == fieldId);
  }

  @override
  void dispose() {
    textDate.dispose();
    textTime.dispose();
    textDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final imageUrl = '$BASE_URL/images/${field.image}';
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              width: screenWidth,
              height: screenHeight * 0.4,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                left: screenWidth * 0.02,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/images/btn_back.png',
                  width: screenWidth * 0.12,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.35),
              padding: EdgeInsets.all(screenWidth * 0.05),
              width: screenWidth,
              height: screenHeight * 0.65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(screenWidth * 0.05),
                ),
                color: darkBlueColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field.name,
                    style: GoogleFonts.poppins(
                      color: whiteColor,
                      fontSize: screenWidth * 0.08,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.07,
                    child: Text(
                      field.description,
                      style: GoogleFonts.poppins(color: whiteColor),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    'Pilih Tanggal & Waktu',
                    style: GoogleFonts.poppins(
                      color: whiteColor,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  Divider(
                    color: whiteColor,
                    thickness: 1,
                    height: 20,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  CustomTextField1(
                    controller: textDate,
                    color: whiteColor,
                    fieldHeight: 0.06,
                    fieldWidth: 0.9,
                    readOnly: true,
                    prefixIcon: FaIcon(
                      FontAwesomeIcons.calendarPlus,
                      color: whiteColor,
                    ),
                    onTap: () {
                      selectDate(context, textDate);
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  CustomTextField1(
                    controller: textTime,
                    color: whiteColor,
                    fieldHeight: 0.06,
                    fieldWidth: 0.9,
                    readOnly: true,
                    prefixIcon: FaIcon(
                      FontAwesomeIcons.clock,
                      color: whiteColor,
                    ),
                    onTap: () {
                      selectTime(context, textTime);
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Durasi Bermain',
                        style: GoogleFonts.poppins(
                          color: whiteColor,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                      CustomTextField1(
                        controller: textDuration,
                        fieldHeight: 0.06,
                        fieldWidth: 0.3,
                        color: whiteColor,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  CustomButton1(
                    title: 'Pesan',
                    onPressed: () {
                      if (textDate.text.isNotEmpty &&
                          textTime.text.isNotEmpty &&
                          textDuration.text.isNotEmpty) {
                        Navigator.pushNamed(context, '/checkout', arguments: {
                          'id': field.id,
                          'quantity': textDuration.text,
                          'booking': true
                        });
                      } else {
                        showErrorDialog(
                            context, 'Peringatan', 'Semua field harus diisi.');
                      }
                    },
                    backgroundColor: orangeColor,
                    colorText: Colors.white,
                    buttonWidth: 0.9,
                    buttonHeight: 0.06,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
