import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/customTextField1.dart';

class ChangeSchedule extends StatefulWidget {
  final DateTime initialDate;
  final TimeOfDay initialTime;

  const ChangeSchedule({
    Key? key,
    required this.initialDate,
    required this.initialTime,
  }) : super(key: key);

  @override
  _ChangeScheduleState createState() => _ChangeScheduleState();
}

class _ChangeScheduleState extends State<ChangeSchedule> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: screenWidth * 0.16,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: screenHeight * 0.04,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        toolbarHeight: screenHeight * 0.1,
        title: Text(
          'Ubah Jadwal',
          style: TextStyle(fontSize: screenHeight * 0.03),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.05),
            width: screenWidth * 0.85,
            height: screenHeight * 0.6,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.calendarCheck,
                        size: screenWidth * 0.1,
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Text(
                        'Pesanan',
                        style: TextStyle(fontSize: screenWidth * 0.06),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Nama Lapangan',
                    style: TextStyle(fontSize: screenWidth * 0.055),
                  ),
                  SizedBox(height: screenHeight * 0.003),
                  Text(
                    'Lapangan A',
                    style: TextStyle(fontSize: screenWidth * 0.045),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.calendar,
                            size: screenWidth * 0.08,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            '${widget.initialDate.day}-${widget.initialDate.month}-${widget.initialDate.year}',
                            style: TextStyle(fontSize: screenWidth * 0.04),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.25,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.clock,
                              size: screenWidth * 0.08,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              '${widget.initialTime.hour}:${widget.initialTime.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    children: [
                      CustomTextField1(
                        fontSize: screenWidth * 0.03,
                        fieldHeight: 0.05,
                        fieldWidth: 0.35,
                        keyboardType: TextInputType.datetime,
                        prefixIcon: FaIcon(FontAwesomeIcons.calendar),
                        enabled: false,
                        controller: TextEditingController(
                          text:
                              '${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}',
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      CustomButton1(
                        title: 'Ubah Tanggal',
                        onPressed: () {
                          _selectDate(context);
                        },
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        buttonWidth: 0.28,
                        buttonHeight: 0.05,
                        fontSize: screenWidth * 0.025,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      CustomTextField1(
                        fontSize: screenWidth * 0.03,
                        fieldHeight: 0.05,
                        fieldWidth: 0.35,
                        keyboardType: TextInputType.datetime,
                        prefixIcon: FaIcon(FontAwesomeIcons.clock),
                        enabled: false,
                        controller: TextEditingController(
                          text:
                              '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      CustomButton1(
                        title: 'Ubah Waktu',
                        onPressed: () {
                          _selectTime(context);
                        },
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        buttonWidth: 0.28,
                        buttonHeight: 0.05,
                        fontSize: screenWidth * 0.025,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  CustomButton1(
                    title: 'Konfirmasi',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/activity', (route) => false);
                    },
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    buttonWidth: 0.35,
                    buttonHeight: 0.07,
                    fontSize: screenWidth * 0.045,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );

    if (newDate != null) {
      setState(() {
        selectedDate = newDate;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final newTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!);
        });

    if (newTime != null) {
      setState(() {
        selectedTime = newTime;
      });
    }
  }
}
