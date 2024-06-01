import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/bookingProvider.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/theme.dart';

class StatusBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bookingData = Provider.of<BookingProvider>(context);
    final bookings = bookingData.bookings;
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Container(
          decoration: BoxDecoration(
            color: darkBlueColor,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          height: screenHeight * 0.28,
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final sizeWidth = constraints.maxWidth;
                final sizeHeight = constraints.maxHeight;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.calendarCheck,
                          color: orangeColor,
                          size: sizeWidth * 0.13,
                        ),
                        SizedBox(
                          width: sizeWidth * 0.05,
                        ),
                        Text(
                          'Pesanan',
                          style: GoogleFonts.poppins(
                              color: whiteColor, fontSize: sizeHeight * 0.13),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizeHeight * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Lapangan',
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: sizeHeight * 0.09),
                            ),
                            Text(
                              booking.name,
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: sizeHeight * 0.09),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status Pesanan',
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: sizeHeight * 0.09),
                            ),
                            Text(
                              booking.statusBook,
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: sizeHeight * 0.09),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizeHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FaIcon(FontAwesomeIcons.solidCalendarDays,
                                color: orangeColor, size: sizeWidth * 0.08),
                            SizedBox(
                              width: sizeWidth * 0.02,
                            ),
                            Text(
                              '${booking.schedule.day.toString().padLeft(2, '0')}-${booking.schedule.month.toString().padLeft(2, '0')}-${booking.schedule.year}',
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: sizeHeight * 0.09),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: sizeWidth * 0.4,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.clock,
                                color: orangeColor,
                                size: sizeWidth * 0.08,
                              ),
                              SizedBox(
                                width: sizeWidth * 0.02,
                              ),
                              Text(
                                '${booking.clock.hour}:${booking.clock.minute.toString().padLeft(2, '0')}',
                                style: GoogleFonts.poppins(
                                    color: whiteColor,
                                    fontSize: sizeHeight * 0.09),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizeHeight * 0.05,
                    ),
                    CustomButton1(
                      title: 'Ubah Jadwal',
                      onPressed: () {
                        try {
                          Navigator.pushNamed(
                            context,
                            '/changeSchedule',
                            arguments:
                                booking.id, // Ganti dengan id yang sesuai
                          );
                        } catch (e) {
                          print('Error: $e');
                        }
                      },
                      backgroundColor: orangeColor,
                      colorText: Colors.white,
                      buttonWidth: 0.37,
                      buttonHeight: 0.05,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
