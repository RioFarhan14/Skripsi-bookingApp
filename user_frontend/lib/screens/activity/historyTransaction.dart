import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/historyProvider.dart';
import 'package:user_frontend/utils/theme.dart';

class HistoryTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final historyData = Provider.of<HistoryProvider>(context);
    final historys = historyData.historys;
    return ListView.builder(
      itemCount: historys.length,
      itemBuilder: (context, index) {
        final history = historys[index];
        return Container(
          decoration: BoxDecoration(
            color: darkBlueColor,
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
                      color: orangeColor,
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Text(
                      'Riwayat Transaksi',
                      style: GoogleFonts.poppins(
                          color: whiteColor, fontSize: screenHeight * 0.025),
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
                          style: GoogleFonts.poppins(
                              color: whiteColor, fontSize: screenHeight * 0.02),
                        ),
                        Text(
                          history.name,
                          style: GoogleFonts.poppins(
                              color: whiteColor, fontSize: screenHeight * 0.02),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status Pesanan',
                          style: GoogleFonts.poppins(
                              color: whiteColor, fontSize: screenHeight * 0.02),
                        ),
                        Text(
                          history.statusPay,
                          style: GoogleFonts.poppins(
                              color: whiteColor, fontSize: screenHeight * 0.02),
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
                            color: orangeColor, size: screenHeight * 0.03),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Text(
                          history.schedule,
                          style: GoogleFonts.poppins(
                              color: whiteColor, fontSize: screenHeight * 0.02),
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
                            color: orangeColor,
                            size: screenHeight * 0.03,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text(
                            history.clock,
                            style: GoogleFonts.poppins(
                                color: whiteColor,
                                fontSize: screenHeight * 0.02),
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
