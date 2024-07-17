import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/allBookingProvider.dart';
import 'package:user_frontend/providers/authProvider.dart';
import 'package:user_frontend/providers/bookingProvider.dart';
import 'package:user_frontend/providers/fieldProvider.dart';
import 'package:user_frontend/providers/helpProvider.dart';
import 'package:user_frontend/providers/historyProvider.dart';
import 'package:user_frontend/providers/informationProvider.dart';
import 'package:user_frontend/providers/membershipProvider.dart';
import 'package:user_frontend/providers/productProvider.dart';
import 'package:user_frontend/services/product-service.dart';
import './route.dart'; // Import router

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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductProvider(ProductService())),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => FieldProvider()),
        ChangeNotifierProvider(create: (_) => MembershipProvider()),
        ChangeNotifierProvider(create: (_) => HelpProvider()),
        ChangeNotifierProvider(create: (_) => InformationProvider()),
        ChangeNotifierProvider(create: (_) => AllBookingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
