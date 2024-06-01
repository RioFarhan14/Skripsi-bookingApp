import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/bookingProvider.dart';
import 'package:user_frontend/utils/customAppBar.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/customTextField1.dart';
import 'package:user_frontend/utils/theme.dart';

class ChangeSchedule extends StatefulWidget {
  const ChangeSchedule({Key? key}) : super(key: key);

  @override
  _ChangeScheduleState createState() => _ChangeScheduleState();
}

class _ChangeScheduleState extends State<ChangeSchedule> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bookingId = ModalRoute.of(context)!.settings.arguments as int;
      final booking = Provider.of<BookingProvider>(context, listen: false)
          .bookings
          .firstWhere((booking) => booking.id == bookingId);
      setState(() {
        selectedDate = booking.schedule;
        selectedTime = booking.clock;
        isInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (!isInitialized) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.1),
          child: const CustomAppBar(title: 'Ubah Jadwal'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: const CustomAppBar(title: 'Ubah Jadwal'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.05),
            width: screenWidth * 0.85,
            height: screenHeight * 0.6,
            decoration: BoxDecoration(
              color: darkBlueColor,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FaIcon(
                        color: orangeColor,
                        FontAwesomeIcons.calendarCheck,
                        size: screenWidth * 0.1,
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Text(
                        'Pesanan',
                        style: GoogleFonts.poppins(
                            color: whiteColor, fontSize: screenWidth * 0.06),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Nama Lapangan',
                    style: GoogleFonts.poppins(
                        color: whiteColor, fontSize: screenWidth * 0.055),
                  ),
                  SizedBox(height: screenHeight * 0.003),
                  Text(
                    'Lapangan A',
                    style: GoogleFonts.poppins(
                        color: whiteColor, fontSize: screenWidth * 0.045),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            color: orangeColor,
                            FontAwesomeIcons.calendar,
                            size: screenWidth * 0.08,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                            style: GoogleFonts.poppins(
                                color: whiteColor,
                                fontSize: screenWidth * 0.04),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.25,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              color: orangeColor,
                              FontAwesomeIcons.clock,
                              size: screenWidth * 0.08,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}',
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    children: [
                      CustomTextField1(
                        backgroundColor: whiteColor,
                        fontSize: screenWidth * 0.03,
                        fieldHeight: 0.05,
                        fieldWidth: 0.35,
                        keyboardType: TextInputType.datetime,
                        prefixIcon: FaIcon(
                            color: orangeColor, FontAwesomeIcons.calendar),
                        enabled: false,
                        controller: TextEditingController(
                          text:
                              '${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}',
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      CustomButton1(
                        title: 'Ubah Tanggal',
                        onPressed: () {
                          _selectDate(context);
                        },
                        backgroundColor: orangeColor,
                        colorText: Colors.white,
                        buttonWidth: 0.28,
                        buttonHeight: 0.05,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      CustomTextField1(
                        backgroundColor: whiteColor,
                        fontSize: screenWidth * 0.03,
                        fieldHeight: 0.05,
                        fieldWidth: 0.35,
                        keyboardType: TextInputType.datetime,
                        prefixIcon:
                            FaIcon(color: orangeColor, FontAwesomeIcons.clock),
                        enabled: false,
                        controller: TextEditingController(
                          text:
                              '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      CustomButton1(
                        title: 'Ubah Waktu',
                        onPressed: () {
                          _selectTime(context);
                        },
                        backgroundColor: orangeColor,
                        colorText: Colors.white,
                        buttonWidth: 0.28,
                        buttonHeight: 0.05,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  CustomButton1(
                    title: 'Konfirmasi',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/activity', (route) => false);
                    },
                    backgroundColor: orangeColor,
                    colorText: Colors.white,
                    buttonWidth: 0.4,
                    buttonHeight: 0.07,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    try {
      final currentDate = DateTime.now();
      final newInitialDate = selectedDate.isBefore(currentDate) ||
              selectedDate.isAfter(currentDate.add(const Duration(days: 7)))
          ? currentDate
          : selectedDate;

      final newDate = await showDatePicker(
        context: context,
        initialDate: newInitialDate,
        firstDate: currentDate,
        lastDate: currentDate.add(const Duration(days: 7)),
      );

      if (newDate != null) {
        setState(() {
          selectedDate = newDate;
        });
      }
    } catch (error) {
      print("Error selecting date: $error");
    }
  }

  void _selectTime(BuildContext context) async {
    final newTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!);
        });

    if (newTime != null) {
      setState(() {
        selectedTime = newTime;
      });
    }
  }
}
