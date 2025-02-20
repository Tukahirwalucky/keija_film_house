import 'package:flutter/material.dart';
import 'dart:async'; // For the delay

// Import the LoginPage
// ignore: unused_import
import 'package:keija_film_house/screens/login_page.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 30 seconds before navigating to the LoginPage
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()), // Navigate to login screen
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color of the splash screen
      body: Center(
        child: Image.asset(
          'assets/images/Logo.jpg', // Your splash screen logo image
          height: 200, // Adjust size as needed
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
