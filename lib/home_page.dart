import 'package:flutter/material.dart';
import 'weather_list_page.dart';
import 'weather_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('天氣查詢'),
          bottom: const TabBar(tabs: [Tab(text: '台北'), Tab(text: '東京')]),
        ),
        drawer: const WeatherDrawer(), // 加入 Drawer
        body: const TabBarView(
          children: [
            CurrentWeatherView(city: '台北'), // 台北天氣
            CurrentWeatherView(city: '東京'), // 東京天氣
          ],
        ),
      ),
    );
  }
}

class CurrentWeatherView extends StatelessWidget {
  final String city;

  const CurrentWeatherView({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    // 假設這裡顯示指定地區的天氣資訊
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('當前地區：$city', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 10),
          Text('溫度：25°C', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),
          Text('天氣：晴天', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
