import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home_view.dart';
import 'views/news_list_view.dart';
import 'views/places_view.dart';
import 'providers/auth_provider.dart';

class TourPoliceApp extends StatelessWidget {
  const TourPoliceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Tour Police',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomeView(),
          '/news': (context) => const NewsListView(),
          '/places': (context) => const PlacesView(),
        },
      ),
    );
  }
}