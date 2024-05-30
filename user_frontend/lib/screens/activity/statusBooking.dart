import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_frontend/screens/activity/changeSchedule.dart';
import 'package:user_frontend/utils/customBotton1.dart';

class BookingItem {
  final String nameField;
  final String statusBook;
  final DateTime schedule;
  final TimeOfDay clock;

  BookingItem({
    required this.nameField,
    required this.statusBook,
    required this.schedule,
    required this.clock,
  });
}

class StatusBooking extends StatelessWidget {
  final List<BookingItem> bookings = [
    BookingItem(
        nameField: 'Lapangan A',
        statusBook: 'Dipesan',
        schedule: DateTime(2024, 5, 23),
        clock: const TimeOfDay(hour: 14, minute: 0)),
    BookingItem(
        nameField: 'Lapangan B',
        statusBook: 'Tersedia',
        schedule: DateTime(2024, 6, 13),
        clock: TimeOfDay(hour: 16, minute: 0)),
    BookingItem(
        nameField: 'Lapangan C',
        statusBook: 'Dipesan',
        schedule: DateTime(2024, 6, 14),
        clock: TimeOfDay(hour: 18, minute: 0))
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          height: screenHeight * 0.28,
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.calendarCheck,
                      size: screenHeight * 0.045,
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Text(
                      'Pesanan',
                      style: TextStyle(fontSize: screenHeight * 0.025),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Lapangan',
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                        Text(
                          booking.nameField,
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status Pesanan',
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                        Text(
                          booking.statusBook,
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FaIcon(FontAwesomeIcons.solidCalendarDays,
                            size: screenHeight * 0.03),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Text(
                          '${booking.schedule.day.toString().padLeft(2, '0')}-${booking.schedule.month.toString().padLeft(2, '0')}-${booking.schedule.year}',
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: screenWidth * 0.28,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.clock,
                            size: screenHeight * 0.03,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text(
                            '${booking.clock.hour}:${booking.clock.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: screenHeight * 0.02),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                CustomButton1(
                  title: 'Ubah Jadwal',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeSchedule(
                          initialDate: booking.schedule,
                          initialTime: booking.clock,
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  buttonWidth: 0.37,
                  buttonHeight: 0.05,
                  fontSize: screenHeight * 0.02,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
