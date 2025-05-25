import 'package:flutter/material.dart';
import 'package:tour_police_flutter/models/news_model.dart';
import 'package:tour_police_flutter/services/news_service.dart';
import 'news_detail_view.dart';

class NewsListView extends StatefulWidget {
  const NewsListView({super.key});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  late Future<List<NewsModel>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = NewsService().getNews();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Новости'),
      centerTitle: true,
    ),
    body: FutureBuilder<List<NewsModel>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }

        final List<NewsModel>? newsList = snapshot.data;

        if (!snapshot.hasData || newsList == null || newsList.isEmpty) {
          return const Center(child: Text('Нет новостей'));
        }

        return ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final news = newsList[index];
            return ListTile(
              leading: Image.network(news.imageUrl ?? 'https://via.placeholder.com/600x400 '),
              title: Text(news.title ?? 'Без заголовка'),
              subtitle: Text(news.content ?? ''),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailView(news: news),
                  ),
                );
              },
            );
          },
        );
      },
    ),
  );
  }
}