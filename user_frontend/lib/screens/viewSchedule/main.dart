import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/customTextField1.dart'; // Sesuaikan dengan nama file sebenarnya

class ViewSchedulePage extends StatefulWidget {
  const ViewSchedulePage({super.key});

  @override
  State<ViewSchedulePage> createState() => _ViewSchedulePageState();
}

class _ViewSchedulePageState extends State<ViewSchedulePage> {
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
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
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
          'Lihat Jadwal',
          style: TextStyle(fontSize: sizeWidth * 0.07),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(sizeWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Lapangan',
              style: TextStyle(fontSize: sizeWidth * 0.06),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: sizeWidth * 0.03, vertical: sizeHeight * 0.015),
              height: sizeHeight * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: sizeWidth * 0.05),
                    padding: EdgeInsets.all(sizeWidth * 0.025),
                    height: sizeHeight * 0.2,
                    width: sizeWidth * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(sizeWidth * 0.06)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(sizeWidth * 0.06),
                              bottom: Radius.circular(sizeWidth * 0.02)),
                          child: Image.network(
                            'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020',
                            width: sizeWidth * 0.45,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(sizeWidth * 0.01),
                          child: Text(
                            'Lapangan A',
                            style: TextStyle(fontSize: sizeWidth * 0.045),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: 3,
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
                    fieldHeight: 0.08,
                    fieldWidth: 0.8,
                    readOnly: true,
                    prefixIcon: const FaIcon(FontAwesomeIcons.calendarCheck),
                    onTap: () {},
                  ),
                  CustomButton1(
                    title: 'Cari',
                    onPressed: () {},
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    buttonWidth: 0.25,
                    buttonHeight: 0.06,
                  ),
                  SizedBox(
                    height: sizeHeight * 0.02,
                  ),
                  Container(
                    width: sizeWidth * 0.9,
                    height: sizeHeight * 0.3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'Nama Pemesan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Waktu',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(_data.length, (index) {
                            return DataRow(
                              color: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                // Even rows will have a different color
                                if (index % 2 == 0)
                                  return Colors.grey.withOpacity(0.3);
                                return null; // Use default value for odd rows
                              }),
                              cells: [
                                DataCell(
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      _data[index]['Nama Pemesan']!,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      _data[index]['Waktu']!,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
