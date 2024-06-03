import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/informationProvider.dart';
import 'package:user_frontend/utils/customAppBar.dart';
import 'package:user_frontend/utils/theme.dart';

class InformationPage extends StatelessWidget {
  InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    final infoData = Provider.of<InformationProvider>(context);
    final informations = infoData.informations;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.1),
        child: const CustomAppBar(title: 'Notifikasi'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: sizeHeight * 0.02),
          width: sizeWidth * 0.8,
          child: ListView.builder(
            itemCount: informations.length,
            itemBuilder: (context, index) {
              final Information = informations[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: sizeHeight * 0.01),
                width: sizeWidth * 0.5,
                height: sizeHeight * 0.2,
                decoration: BoxDecoration(
                    color: darkBlueColor,
                    borderRadius: BorderRadius.circular(sizeWidth * 0.05)),
                child: Padding(
                  padding: EdgeInsets.all(sizeWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Information.title,
                        style: GoogleFonts.poppins(
                            color: whiteColor, fontSize: sizeWidth * 0.06),
                      ),
                      SizedBox(
                        height: sizeHeight * 0.01,
                      ),
                      SizedBox(
                          width: sizeWidth * 0.8,
                          height: sizeHeight * 0.06,
                          child: Text(
                            Information.text,
                            style: GoogleFonts.poppins(
                                color: whiteColor, fontSize: sizeWidth * 0.035),
                          )),
                      SizedBox(
                        height: sizeHeight * 0.01,
                      ),
                      Text(
                        '${Information.time.day.toString().padLeft(2, '0')}-${Information.time.month.toString().padLeft(2, '0')}-${Information.time.year}, ${Information.time.hour.toString().padLeft(2, '0')}:${Information.time.minute.toString().padLeft(2, '0')}',
                        style: GoogleFonts.poppins(color: whiteColor),
                      )
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
