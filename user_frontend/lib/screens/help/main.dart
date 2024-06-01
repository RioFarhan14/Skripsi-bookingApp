import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_frontend/utils/customAppBar.dart';
import 'package:user_frontend/utils/theme.dart';
import '../../models/help.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  List<Help> infoHelps = [
    Help(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
    Help(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
    Help(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
    Help(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.1),
        child: const CustomAppBar(title: 'Bantuan'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: sizeHeight * 0.02,
              horizontal: sizeWidth * 0.075,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pertanyaan Umum Yang',
                  style: GoogleFonts.poppins(
                      fontSize: sizeWidth * 0.05, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Sering Diajukan',
                  style: GoogleFonts.poppins(
                      fontSize: sizeWidth * 0.05, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: sizeWidth * 0.85,
                child: ListView.builder(
                  itemCount: infoHelps.length,
                  itemBuilder: (context, index) {
                    final infoHelp = infoHelps[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: sizeHeight * 0.01),
                      decoration: BoxDecoration(
                          color: darkBlueColor,
                          borderRadius:
                              BorderRadius.circular(sizeWidth * 0.03)),
                      child: ExpansionTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sizeWidth * 0.03),
                        ),
                        title: Text(
                          infoHelp.title,
                          style: GoogleFonts.poppins(color: whiteColor),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeHeight * 0.02,
                                vertical: sizeHeight * 0.02),
                            child: Text(
                              infoHelp.detail,
                              style: GoogleFonts.poppins(color: whiteColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            width: sizeWidth,
            padding: EdgeInsets.all(sizeWidth * 0.04),
            decoration: BoxDecoration(
                color: darkBlueColor,
                borderRadius: BorderRadiusDirectional.vertical(
                    top: Radius.circular(sizeWidth * 0.04))),
            height: sizeHeight * 0.15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Masih Butuh Bantuan ?',
                  style: GoogleFonts.poppins(
                      color: orangeColor, fontSize: sizeWidth * 0.05),
                ),
                SizedBox(
                  height: sizeHeight * 0.01,
                ),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.phoneVolume,
                      size: sizeWidth * 0.08,
                      color: orangeColor,
                    ),
                    SizedBox(
                      width: sizeWidth * 0.05,
                    ),
                    Text(
                      '021 XXXXXXXXXX',
                      style: GoogleFonts.poppins(
                          fontSize: sizeWidth * 0.05, color: orangeColor),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
