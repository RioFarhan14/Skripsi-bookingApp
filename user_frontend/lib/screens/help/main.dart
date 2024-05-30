import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoHelp {
  final String title;
  final String detail;

  InfoHelp({required this.title, required this.detail});
}

class HelpPage extends StatefulWidget {
  HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  List<InfoHelp> infoHelps = [
    InfoHelp(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
    InfoHelp(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
    InfoHelp(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
    InfoHelp(
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
        child: AppBar(
          leadingWidth: sizeWidth * 0.16,
          leading: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sizeWidth * 0.02,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              child: GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: sizeHeight * 0.04,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          toolbarHeight: sizeHeight * 0.1,
          title: Text(
            'Bantuan',
            style: TextStyle(
              fontSize: sizeHeight * 0.03,
            ),
          ),
          centerTitle: true,
        ),
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
                  style: TextStyle(
                      fontSize: sizeWidth * 0.05, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Sering Diajukan',
                  style: TextStyle(
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
                          color: const Color.fromARGB(255, 107, 179, 109),
                          borderRadius:
                              BorderRadius.circular(sizeWidth * 0.03)),
                      child: ExpansionTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sizeWidth * 0.03),
                        ),
                        title: Text(infoHelp.title),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeHeight * 0.02,
                                vertical: sizeHeight * 0.02),
                            child: Text(infoHelp.detail),
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
                color: Colors.green,
                borderRadius: BorderRadiusDirectional.vertical(
                    top: Radius.circular(sizeWidth * 0.04))),
            height: sizeHeight * 0.15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Masih Butuh Bantuan ?',
                  style: TextStyle(fontSize: sizeWidth * 0.05),
                ),
                SizedBox(
                  height: sizeHeight * 0.01,
                ),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.phoneVolume,
                      size: sizeWidth * 0.08,
                    ),
                    SizedBox(
                      width: sizeWidth * 0.05,
                    ),
                    Text(
                      '021 XXXXXXXXXX',
                      style: TextStyle(fontSize: sizeWidth * 0.05),
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
