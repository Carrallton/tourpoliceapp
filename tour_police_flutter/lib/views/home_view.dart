// lib/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Tour Police'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              authProvider.user?.username ?? 'Гость',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/news');
              },
              child: const Text('Новости'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/places');
              },
              child: const Text('Места'),
            ),
          ],
        ),
      ),
    );
  }
}