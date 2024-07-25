import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/FaqProvider.dart';
import 'package:user_frontend/providers/authProvider.dart';
import 'package:user_frontend/providers/bookingProvider.dart';
import 'package:user_frontend/providers/fieldProvider.dart';
import 'package:user_frontend/providers/helpProvider.dart';
import 'package:user_frontend/providers/historyProvider.dart';
import 'package:user_frontend/providers/informationProvider.dart';
import 'package:user_frontend/providers/productProvider.dart';
import 'package:user_frontend/providers/transactionProvider.dart';
import 'package:user_frontend/services/faq-service.dart';
import 'package:user_frontend/services/product-service.dart';
import 'package:user_frontend/services/transaction-service.dart';
import './route.dart'; // Import router

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductProvider(ProductService())),
        ChangeNotifierProvider(
            create: (_) => TransactionProvider(TransactionService())),
        ChangeNotifierProvider(create: (_) => FaqProvider(FaqService())),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => FieldProvider()),
        ChangeNotifierProvider(create: (_) => HelpProvider()),
        ChangeNotifierProvider(create: (_) => InformationProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
