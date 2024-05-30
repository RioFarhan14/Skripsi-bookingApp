import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/screens/aboutMe/main.dart';
import 'package:user_frontend/screens/booking/detailBooking.dart';
import 'package:user_frontend/screens/booking/main.dart';
import 'package:user_frontend/screens/checkout.dart';
import 'package:user_frontend/screens/help/main.dart';
import 'package:user_frontend/screens/menuNavigation.dart';
import 'package:user_frontend/screens/notif/main.dart';
import 'package:user_frontend/screens/viewSchedule/main.dart';

// Model
class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// Fungsi utama
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

// Kelas MyApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/menuNavigation',
        routes: {
          '/menuNavigation': (context) => const MenuNavigation(),
          '/home': (context) => const MenuNavigation(initialIndex: 0),
          '/activity': (context) => const MenuNavigation(initialIndex: 1),
          '/profile': (context) => const MenuNavigation(initialIndex: 2),
          '/notification': (context) => NotificationPage(),
          '/booking': (context) => BookingFieldPage(),
          '/detailBook': (context) => DetailBookingPage(),
          '/checkout': (context) => CheckoutPage(),
          '/help': (context) => HelpPage(),
          '/viewSchedule': (context) => ViewSchedulePage(),
          '/aboutMe': (context) => AboutMe()
        },
      ),
    );
  }
}
