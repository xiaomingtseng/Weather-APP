import 'package:flutter/material.dart';

class WeatherDetailPage extends StatelessWidget {
  final String city;

  const WeatherDetailPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$city 天氣')),
      body: Center(
        child: Text(
          '這裡顯示 $city 的詳細天氣資訊',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
