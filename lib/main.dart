import 'package:flutter/material.dart';
//import 'package:keija_film_house/screens/splash_screen.dart';  // Uncomment if needed
// ignore: unused_import
import 'package:keija_film_house/screens/screens/form_screen.dart';  // Ensure this path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keija Film House',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const FormScreen(), // Ensure FormScreen is correctly defined
      debugShowCheckedModeBanner: false,
    );
  }
}

