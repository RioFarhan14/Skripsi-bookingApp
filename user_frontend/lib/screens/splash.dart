import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/authProvider.dart';
import 'package:user_frontend/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      _checkAuthentication();
    });
  }

  void _checkAuthentication() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isAuthenticated) {
      Navigator.of(context).pushReplacementNamed('/menuNavigation');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.width * 0.6,
        ),
      ),
    );
  }
}
