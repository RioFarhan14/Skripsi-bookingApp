import 'package:flutter/material.dart';

class Notification {
  final String title;
  final String text;
  final DateTime time;

  Notification({
    required this.title,
    required this.text,
    required this.time,
  });
}

// ignore: must_be_immutable
class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});
  final List<Notification> notifications = [
    Notification(
        title: 'Booking',
        text: 'Pesanan anda 15 menit lagi akan di mulai',
        time: DateTime(2024, 23, 05, 15, 27)),
    Notification(
        title: 'Booking',
        text: 'Pesanan anda 15 menit lagi akan di mulai',
        time: DateTime(2024, 23, 05, 15, 27)),
    Notification(
        title: 'Booking',
        text: 'Pesanan anda 15 menit lagi akan di mulai',
        time: DateTime(2024, 23, 05, 15, 27)),
    Notification(
        title: 'Booking',
        text: 'Pesanan anda 15 menit lagi akan di mulai',
        time: DateTime(2024, 23, 05, 15, 27)),
  ];
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.1),
        child: AppBar(
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
            'Notifikasi',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: sizeHeight * 0.02),
          width: sizeWidth * 0.9,
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: sizeHeight * 0.01),
                width: sizeWidth * 0.5,
                height: sizeHeight * 0.2,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(sizeWidth * 0.05)),
                child: Padding(
                  padding: EdgeInsets.all(sizeWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(fontSize: sizeWidth * 0.06),
                      ),
                      SizedBox(
                        height: sizeHeight * 0.01,
                      ),
                      SizedBox(
                          width: sizeWidth * 0.8,
                          height: sizeHeight * 0.06,
                          child: Text(
                            notification.text,
                            style: TextStyle(fontSize: sizeWidth * 0.035),
                          )),
                      SizedBox(
                        height: sizeHeight * 0.01,
                      ),
                      Text(
                          '${notification.time.day.toString().padLeft(2, '0')}-${notification.time.month.toString().padLeft(2, '0')}-${notification.time.year}, ${notification.time.hour.toString().padLeft(2, '0')}:${notification.time.minute.toString().padLeft(2, '0')}')
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
