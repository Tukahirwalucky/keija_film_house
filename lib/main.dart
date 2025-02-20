import 'package:flutter/material.dart';
import 'package:keija_film_house/screens/splash_screen.dart';
//import 'package:keija_film_house/screens/_screen.dart';

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
      home: SplashScreen(), // Ensure FormScreen is correctly defined
      debugShowCheckedModeBanner: false,
    );
  }
}
