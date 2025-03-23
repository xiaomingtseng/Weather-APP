import 'package:flutter/material.dart';
import 'weather_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('天氣查詢')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WeatherListPage(),
                ),
              );
            },
            child: Card(
              child: Center(
                child: Text(
                  '查看天氣列表',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
          // 其他功能按鈕可以在這裡擴展
        ],
      ),
    );
  }
}
