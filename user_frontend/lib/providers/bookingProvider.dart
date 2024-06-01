import 'package:flutter/material.dart';
import '../models/booking.dart';

class BookingProvider with ChangeNotifier {
  final List<BookingItem> _bookings = [
    BookingItem(
        id: 1,
        name: 'Lapangan A',
        statusBook: 'Dipesan',
        schedule: DateTime(2024, 5, 23),
        clock: const TimeOfDay(hour: 14, minute: 0)),
    BookingItem(
        id: 2,
        name: 'Lapangan B',
        statusBook: 'Tersedia',
        schedule: DateTime(2024, 6, 13),
        clock: const TimeOfDay(hour: 16, minute: 0)),
    BookingItem(
        id: 3,
        name: 'Lapangan C',
        statusBook: 'Dipesan',
        schedule: DateTime(2024, 6, 14),
        clock: const TimeOfDay(hour: 18, minute: 0))
  ];

  List<BookingItem> get bookings {
    return [..._bookings];
  }
}
