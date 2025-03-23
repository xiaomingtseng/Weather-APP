import 'package:flutter/material.dart';
import 'weather_list_page.dart';
import 'weather_drawer.dart';
import 'weather_service.dart';

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

class CurrentWeatherView extends StatefulWidget {
  final String city;

  const CurrentWeatherView({super.key, required this.city});

  @override
  _CurrentWeatherViewState createState() => _CurrentWeatherViewState();
}

class _CurrentWeatherViewState extends State<CurrentWeatherView> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? weatherData;
  bool isLoading = true;

  Map<String, String> cityNameMapping = {'台北': 'Taipei', '東京': 'Tokyo'};

  String getCityName(String city) {
    return cityNameMapping[city] ?? city;
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final cityName = getCityName(widget.city);
      final data = await _weatherService.fetchWeather(cityName);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('無法取得天氣資料，請確認城市名稱是否正確')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : weatherData != null
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '地區：${weatherData!['name']}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                '溫度：${weatherData!['main']['temp'].toStringAsFixed(1)}°C',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Text(
                '天氣：${weatherData!['weather'][0]['description']}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Image.network(
                'https://openweathermap.org/img/wn/${weatherData!['weather'][0]['icon']}@2x.png',
              ),
            ],
          ),
        )
        : const Center(child: Text('無法顯示天氣資料'));
  }
}
