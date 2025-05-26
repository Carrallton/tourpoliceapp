import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'views/home_view.dart';
import '../constants.dart'; 

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
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

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context)
  { return super.createHttpClient(context) ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;}
}