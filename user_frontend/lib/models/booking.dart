import 'package:flutter/material.dart';

class BookingItem {
  final int id;
  final String name;
  final String statusBook;
  final DateTime schedule;
  final TimeOfDay clock;

  BookingItem({
    required this.id,
    required this.name,
    required this.statusBook,
    required this.schedule,
    required this.clock,
  });

  get bookings => null;
}
