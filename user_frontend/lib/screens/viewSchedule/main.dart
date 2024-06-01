import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/fieldProvider.dart';
import 'package:user_frontend/utils/customAppBar.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/customTextField1.dart';
import 'package:user_frontend/utils/theme.dart';
import 'package:user_frontend/utils/timeUtils.dart'; // Sesuaikan dengan nama file sebenarnya

class ViewSchedulePage extends StatefulWidget {
  const ViewSchedulePage({super.key});

  @override
  State<ViewSchedulePage> createState() => _ViewSchedulePageState();
}

class _ViewSchedulePageState extends State<ViewSchedulePage> {
  late TextEditingController textDate = TextEditingController();
  final List<Map<String, String>> _data = [
    {"Nama Pemesan": "Alice", "Waktu": "09:00"},
    {"Nama Pemesan": "Bob", "Waktu": "10:00"},
    {"Nama Pemesan": "Charlie", "Waktu": "11:00"},
    {"Nama Pemesan": "David", "Waktu": "12:00"},
    {"Nama Pemesan": "Eve", "Waktu": "13:00"},
    {"Nama Pemesan": "Frank", "Waktu": "14:00"},
    {"Nama Pemesan": "Grace", "Waktu": "15:00"},
    {"Nama Pemesan": "Heidi", "Waktu": "16:00"},
    {"Nama Pemesan": "Ivan", "Waktu": "17:00"},
    {"Nama Pemesan": "Judy", "Waktu": "18:00"},
  ];
  int? _selectedField;

  @override
  Widget build(BuildContext context) {
    final fieldData = Provider.of<FieldProvider>(context);
    final fields = fieldData.fields;
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.1),
        child: const CustomAppBar(title: 'Lihat Jadwal'),
      ),
      body: Padding(
        padding: EdgeInsets.all(sizeWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Lapangan',
              style: GoogleFonts.poppins(fontSize: sizeWidth * 0.06),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: sizeWidth * 0.03, vertical: sizeHeight * 0.015),
              height: sizeHeight * 0.22,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: fields.length,
                itemBuilder: (context, index) {
                  final field = fields[index];
                  final isSelected = _selectedField == field.id;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedField = field.id;
                      });
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: sizeWidth * 0.05),
                      width: sizeWidth * 0.5,
                      decoration: BoxDecoration(
                        color: isSelected ? orangeColor : darkBlueColor,
                        borderRadius: BorderRadius.circular(sizeWidth * 0.04),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(sizeWidth * 0.04),
                                bottom: Radius.circular(sizeWidth * 0.02)),
                            child: Image.network(
                              field.image,
                              width: sizeWidth,
                              height: sizeHeight * 0.15,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: sizeWidth * 0.01, left: sizeWidth * 0.04),
                            child: Text(
                              field.name,
                              style: GoogleFonts.poppins(
                                  fontSize: sizeWidth * 0.045,
                                  color: whiteColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: sizeHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField1(
                    controller: textDate,
                    fieldHeight: 0.08,
                    fieldWidth: 0.8,
                    readOnly: true,
                    prefixIcon: const FaIcon(FontAwesomeIcons.calendarCheck),
                    onTap: () {
                      selectDate(context, textDate);
                    },
                  ),
                  CustomButton1(
                    title: 'Cari',
                    onPressed: () {
                      if (_selectedField != null && textDate.text.isNotEmpty) {
                        _showTable(context);
                      }
                    },
                    backgroundColor: darkBlueColor,
                    colorText: Colors.white,
                    buttonWidth: 0.25,
                    buttonHeight: 0.06,
                  ),
                  SizedBox(
                    height: sizeHeight * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTable(BuildContext context) {
    // Check if data is available
    if (_data.isEmpty) return;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(MediaQuery.of(context).size.width * 0.05)),
      ),
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.34,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: SingleChildScrollView(
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Nama Pemesan',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Waktu',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(_data.length, (index) {
                return DataRow(
                  color: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (index % 2 == 0) {
                      return Colors.grey.withOpacity(0.3);
                    }
                    return null;
                  }),
                  cells: [
                    DataCell(
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.01),
                        child: Text(
                          _data[index]['Nama Pemesan']!,
                          style: GoogleFonts.poppins(fontSize: 14.0),
                        ),
                      ),
                    ),
                    DataCell(
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          _data[index]['Waktu']!,
                          style: GoogleFonts.poppins(fontSize: 14.0),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
