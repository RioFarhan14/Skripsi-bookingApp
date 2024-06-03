import 'package:flutter/material.dart';
import 'package:user_frontend/models/Information.dart';

class InformationProvider with ChangeNotifier {
  final List<Information> _informations = [
    Information(
        title: 'Booking',
        text: 'Pesanan anda 15 menit lagi akan di mulai',
        time: DateTime(2024, 23, 05, 15, 27)),
    Information(
        title: 'Booking',
        text: 'Pesanan anda 15 menit lagi akan di mulai',
        time: DateTime(2024, 23, 05, 15, 27)),
    Information(
        title: 'Booking',
        text: 'Pesanan anda 15 menit lagi akan di mulai',
        time: DateTime(2024, 23, 05, 15, 27)),
    Information(
        title: 'Booking',
        text: 'Pesanan anda 15 menit lagi akan di mulai',
        time: DateTime(2024, 23, 05, 15, 27)),
  ];
  List<Information> get informations {
    return [..._informations];
  }
}
