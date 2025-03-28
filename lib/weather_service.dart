import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  final String apiKey =
      dotenv.env['OPENWEATHER_API_KEY'] ?? ''; // 從 .env 讀取 API 金鑰

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&lang=zh_tw&units=metric',
    );
    print('Requesting weather data for: $city'); // 測試請求的城市名稱
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Weather data: $data'); // 測試回應資料
      return data;
    } else {
      print('Error: ${response.statusCode}, ${response.body}'); // 測試錯誤訊息
      throw Exception('無法取得天氣資料');
    }
  }
}
