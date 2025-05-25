// lib/views/news_detail_view.dart
import 'package:flutter/material.dart';
import 'package:tour_police_flutter/models/news_model.dart';

class NewsDetailView extends StatelessWidget {
  final NewsModel news;

  const NewsDetailView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(news.imageUrl),
            const SizedBox(height: 16),
            Text(
              news.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(news.content),
          ],
        ),
      ),
    );
  }
}