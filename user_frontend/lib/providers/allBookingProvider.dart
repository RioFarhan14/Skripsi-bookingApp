import 'package:flutter/material.dart';
import 'package:user_frontend/models/All_booking.dart';

class AllBookingProvider with ChangeNotifier {
  final List<AllBooking> _bookings = [
    AllBooking(
        namaPemesan: "Alice",
        waktu: "09:00",
        tanggal: "2024-06-01", // Mengubah tipe data menjadi String
        fieldId: 1),
    AllBooking(
        namaPemesan: "Bob",
        waktu: "10:00",
        tanggal: "2024-06-01", // Mengubah tipe data menjadi String
        fieldId: 1),
    AllBooking(
        namaPemesan: "Charlie",
        waktu: "11:00",
        tanggal: "2024-06-01", // Mengubah tipe data menjadi String
        fieldId: 1),
    AllBooking(
        namaPemesan: "David",
        waktu: "12:00",
        tanggal: "2024-06-02", // Mengubah tipe data menjadi String
        fieldId: 2),
    AllBooking(
        namaPemesan: "Eve",
        waktu: "13:00",
        tanggal: "2024-06-02", // Mengubah tipe data menjadi String
        fieldId: 2),
    AllBooking(
        namaPemesan: "Frank",
        waktu: "14:00",
        tanggal: "2024-06-03", // Mengubah tipe data menjadi String
        fieldId: 3),
    AllBooking(
        namaPemesan: "Grace",
        waktu: "15:00",
        tanggal: "2024-06-03", // Mengubah tipe data menjadi String
        fieldId: 3),
    AllBooking(
        namaPemesan: "Heidi",
        waktu: "16:00",
        tanggal: "2024-06-04", // Mengubah tipe data menjadi String
        fieldId: 2),
    AllBooking(
        namaPemesan: "Ivan",
        waktu: "17:00",
        tanggal: "2024-06-04", // Mengubah tipe data menjadi String
        fieldId: 2),
    AllBooking(
        namaPemesan: "Judy",
        waktu: "18:00",
        tanggal: "2024-06-05", // Mengubah tipe data menjadi String
        fieldId: 1),
  ];

  List<AllBooking> get bookings {
    return [..._bookings];
  }

  List<AllBooking> getBookingsByFieldAndDate(int fieldId, String date) {
    return _bookings.where((booking) {
      return booking.fieldId == fieldId && booking.tanggal == date;
    }).toList();
  }
}
