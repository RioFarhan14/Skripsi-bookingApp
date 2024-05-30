import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class historyItem {
  final String nameField;
  final String statusPay;
  final String schedule;
  final String clock;

  historyItem({
    required this.nameField,
    required this.statusPay,
    required this.schedule,
    required this.clock,
  });
}

class HistoryTransaction extends StatelessWidget {
  final List<historyItem> historys = [
    historyItem(
        nameField: 'Lapangan A',
        statusPay: 'Berhasil',
        schedule: '12-06-2024',
        clock: '14:00'),
    historyItem(
        nameField: 'Lapangan B',
        statusPay: 'Gagal',
        schedule: '13-06-2024',
        clock: '16:00'),
    historyItem(
        nameField: 'Lapangan C',
        statusPay: 'Berhasil',
        schedule: '14-06-2024',
        clock: '18:00')
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: historys.length,
      itemBuilder: (context, index) {
        final history = historys[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          height: screenHeight * 0.22,
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.receipt,
                      size: screenHeight * 0.04,
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Text(
                      'Riwayat Transaksi',
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
                          history.nameField,
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
                          history.statusPay,
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
                          history.schedule,
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
                            history.clock,
                            style: TextStyle(fontSize: screenHeight * 0.02),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
