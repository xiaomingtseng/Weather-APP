import 'package:flutter/material.dart';

/// 定義天氣資料的主要結構
class WeatherData {
  final String city; // 城市名稱
  final String temperature; // 當前溫度
  final String highLow; // 高低溫
  final String description; // 天氣描述
  final IconData icon; // 天氣圖示
  final List<HourlyForecast> hourlyForecast; // 每小時預報
  final List<DailyForecast> dailyForecast; // 每日預報

  WeatherData({
    required this.city,
    required this.temperature,
    required this.highLow,
    required this.description,
    required this.icon,
    required this.hourlyForecast,
    required this.dailyForecast,
  });
}

/// 定義每小時預報的結構
class HourlyForecast {
  final String time; // 時間
  final String temperature; // 溫度
  final IconData icon; // 天氣圖示

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.icon,
  });
}

/// 定義每日預報的結構
class DailyForecast {
  final String date; // 日期
  final String highLow; // 高低溫
  final String description; // 天氣描述
  final IconData icon; // 天氣圖示

  DailyForecast({
    required this.date,
    required this.highLow,
    required this.description,
    required this.icon,
  });
}
