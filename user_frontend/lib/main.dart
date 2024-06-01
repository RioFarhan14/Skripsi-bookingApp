import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/bookingProvider.dart';
import 'package:user_frontend/providers/fieldProvider.dart';
import 'package:user_frontend/providers/historyProvider.dart';
import 'package:user_frontend/providers/membershipProvider.dart';
import 'package:user_frontend/screens/aboutMe/main.dart';
import 'package:user_frontend/screens/activity/changeSchedule.dart';
import 'package:user_frontend/screens/booking/detailBooking.dart';
import 'package:user_frontend/screens/booking/main.dart';
import 'package:user_frontend/screens/checkout.dart';
import 'package:user_frontend/screens/help/main.dart';
import 'package:user_frontend/screens/information/main.dart';
import 'package:user_frontend/screens/menuNavigation.dart';
import 'package:user_frontend/screens/membership/main.dart';
import 'package:user_frontend/screens/viewSchedule/main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => FieldProvider()),
        ChangeNotifierProvider(create: (_) => MembershipProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/menuNavigation',
        routes: {
          '/menuNavigation': (context) => MenuNavigation(),
          '/home': (context) => MenuNavigation(initialIndex: 0),
          '/activity': (context) => MenuNavigation(initialIndex: 1),
          '/profile': (context) => MenuNavigation(initialIndex: 2),
          '/information': (context) => InformationPage(),
          '/booking': (context) => BookingFieldPage(),
          '/detailBook': (context) => DetailBookingPage(),
          '/checkout': (context) => CheckoutPage(),
          '/help': (context) => HelpPage(),
          '/viewSchedule': (context) => ViewSchedulePage(),
          '/aboutMe': (context) => AboutMe(),
          '/membership': (context) => MembershipPage(),
          '/changeSchedule': (context) => ChangeSchedule(),
        },
      ),
    );
  }
}
