import 'package:flutter/material.dart';
import '../models/history.dart';

class HistoryProvider with ChangeNotifier {
  final List<HistoryItem> _historys = [
    HistoryItem(
        id: 1,
        name: 'Lapangan A',
        statusPay: 'Berhasil',
        schedule: '12-06-2024',
        clock: '14:00'),
    HistoryItem(
        id: 2,
        name: 'Lapangan B',
        statusPay: 'Gagal',
        schedule: '13-06-2024',
        clock: '16:00'),
    HistoryItem(
        id: 3,
        name: 'Lapangan C',
        statusPay: 'Berhasil',
        schedule: '14-06-2024',
        clock: '18:00')
  ];

  List<HistoryItem> get historys {
    return [..._historys];
  }
}
