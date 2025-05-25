import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'views/home_view.dart';
import '../constants.dart'; 

void main() async {
  print("API Base URL: $apiBaseUrl");
  runApp(const TourPoliceApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tour Police',
      home: HomeView(),
    );
  }
}