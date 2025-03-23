import 'package:flutter/material.dart';
import 'weather_detail_page.dart';

class WeatherListPage extends StatelessWidget {
  const WeatherListPage({super.key});

  final List<String> cities = const ['台北', '台中', '高雄', '台南', '新竹'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('天氣列表')),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeatherDetailPage(city: cities[index]),
                ),
              );
            },
            child: Card(
              child: ListTile(
                title: Text(cities[index]),
                subtitle: const Text('點擊查看詳細天氣'),
              ),
            ),
          );
        },
      ),
    );
  }
}
