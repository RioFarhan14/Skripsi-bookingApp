import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/customTextField1.dart';
import 'dart:async'; // Import dart:async untuk menggunakan Future

class DetailBookingPage extends StatefulWidget {
  const DetailBookingPage({Key? key}) : super(key: key);

  @override
  State<DetailBookingPage> createState() => _DetailBookingPageState();
}

class _DetailBookingPageState extends State<DetailBookingPage> {
  late TextEditingController textDate = TextEditingController();
  late TextEditingController textTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.network(
                'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020',
                width: screenWidth,
                height: screenHeight * 0.4,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.02,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 241, 240, 240),
                      shape: BoxShape.circle,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.angleLeft,
                      size: screenHeight * 0.05,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.35),
                padding: EdgeInsets.all(screenWidth * 0.05),
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(screenWidth * 0.05),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lapangan A',
                      style: TextStyle(fontSize: screenWidth * 0.08),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    SizedBox(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.07,
                      child: const Text(
                        'Lewifbewfekfnewfiueewfewfweewfewfewfwfi',
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      'Pilih Tanggal & Waktu',
                      style: TextStyle(fontSize: screenWidth * 0.05),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 20,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    CustomTextField1(
                      controller: textDate,
                      fieldHeight: 0.06,
                      fieldWidth: 0.9,
                      readOnly: true,
                      prefixIcon: const FaIcon(FontAwesomeIcons.calendarPlus),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    CustomTextField1(
                      controller: textTime,
                      fieldHeight: 0.06,
                      fieldWidth: 0.9,
                      readOnly: true,
                      prefixIcon: const FaIcon(FontAwesomeIcons.clock),
                      onTap: () {
                        _selectTime(context);
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Durasi Bermain',
                          style: TextStyle(fontSize: screenWidth * 0.05),
                        ),
                        CustomTextField1(
                          fieldHeight: 0.06,
                          fieldWidth: 0.3,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    CustomButton1(
                        title: 'Pesan',
                        onPressed: () {
                          Navigator.pushNamed(context, '/checkout');
                        },
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        buttonWidth: 0.9,
                        buttonHeight: 0.06)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        textDate.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      int pickedSeconds = picked.hour * 3600 + picked.minute * 60;
      int startTimeSeconds = 9 * 3600; // 9 pagi
      int endTimeSeconds = 21 * 3600; // 9 malam

      if (pickedSeconds >= startTimeSeconds &&
          pickedSeconds <= endTimeSeconds) {
        setState(() {
          textTime.text =
              '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
        });
      } else {
        // ignore: use_build_context_synchronously
        _showErrorDialog(context);
      }
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              FaIcon(
                FontAwesomeIcons.triangleExclamation,
                color: Colors.red,
              ),
              SizedBox(width: 13),
              Text(
                'Peringatan',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          content: const Text('Pilih waktu antara 09:00 sampai 21:00'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
