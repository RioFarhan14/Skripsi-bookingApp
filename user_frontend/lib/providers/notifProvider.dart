import 'dart:async';
import 'package:flutter/material.dart';
import 'package:user_frontend/services/notification-service.dart'; // Pastikan path impor sesuai

class NotificationProvider with ChangeNotifier {
  final NotifService _notifService = NotifService();

  List<Map<String, dynamic>> notifications = [];
  List<Map<String, dynamic>> notificationReads = [];
  List<Map<String, dynamic>> notificationCategories = [];

  Timer? _timer;

  NotificationProvider() {
    _fetchData();
    _startAutoRefresh();
  }

  get isButtonPressed => null;

  Future<void> _fetchData() async {
    try {
      final data = await _notifService.get();
      notifications = data['notifications']!;
      notificationReads = data['notificationReads']!;
      notificationCategories = data['notificationCategories']!;
      notifyListeners();
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      _fetchData();
    });
  }

  void isRead(int notificationId) async {
    try {
      final List<Map<String, dynamic>> response =
          await _notifService.isRead(notificationId);

      if (response.isNotEmpty) {
        final updatedNotification = response.first;
        print(updatedNotification);

        // Update atau tambahkan notifikasi
        notificationReads = notificationReads.map((notification) {
          if (notification['notification_id'] == notificationId) {
            // Jika notifikasi sudah ada, perbarui atribut is_read
            return {
              ...notification,
              'is_read': updatedNotification['is_read'],
            };
          }
          return notification;
        }).toList();

        // Tambahkan notifikasi baru jika belum ada dalam list
        if (notificationReads.every((notification) =>
            notification['notification_id'] != notificationId)) {
          notificationReads.add(updatedNotification);
        }

        notifyListeners();
      } else {
        throw Exception('No notifications found');
      }
    } catch (e) {
      print('Error submit isRead: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
