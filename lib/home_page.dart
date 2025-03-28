import 'package:flutter/material.dart';
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
  CurrentWeatherViewState createState() => CurrentWeatherViewState();
}

class CurrentWeatherViewState extends State<CurrentWeatherView> {
  // 靜態假資料
  final Map<String, dynamic> currentWeather = {
    'temperature': '25.0°C',
    'highLow': '高: 28°C / 低: 22°C',
    'location': '台北',
  };

  final List<Map<String, dynamic>> hourlyForecast = List.generate(
    12,
    (index) => {
      'hour': '${6 + index}:00',
      'temp': '${22 + index % 5}°C',
      'icon': Icons.wb_sunny,
    },
  );

  final List<Map<String, dynamic>> tenDayForecast = [
    {'day': '星期一', 'high': '28°C', 'low': '22°C', 'weather': '晴天'},
    {'day': '星期二', 'high': '27°C', 'low': '21°C', 'weather': '多雲'},
    {'day': '星期三', 'high': '26°C', 'low': '20°C', 'weather': '小雨'},
    {'day': '星期四', 'high': '29°C', 'low': '23°C', 'weather': '晴天'},
    {'day': '星期五', 'high': '25°C', 'low': '22°C', 'weather': '雷陣雨'},
    {'day': '星期六', 'high': '30°C', 'low': '24°C', 'weather': '晴天'},
    {'day': '星期日', 'high': '31°C', 'low': '25°C', 'weather': '晴天'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('天氣資訊 - ${widget.city}')),
      body: Column(
        children: [
          // 當前天氣資訊
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentWeather['temperature'],
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4.0),
                Text(
                  currentWeather['highLow'],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4.0),
                Text(
                  currentWeather['location'],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 12 小時預報
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '12 小時天氣預報',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: 150.0,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.5,
                            mainAxisSpacing: 8.0,
                          ),
                      itemCount: hourlyForecast.length,
                      itemBuilder: (context, index) {
                        final forecast = hourlyForecast[index];
                        return Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  forecast['hour'],
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 8.0),
                                Icon(
                                  forecast['icon'],
                                  size: 40.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  forecast['temp'],
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // 10 天預報
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '10 天天氣預報',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tenDayForecast.length,
                    itemBuilder: (context, index) {
                      final forecast = tenDayForecast[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.wb_sunny, // 可根據天氣狀況動態更改圖示
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text('${forecast['day']}'),
                          subtitle: Text('${forecast['weather']}'),
                          trailing: Text(
                            '高: ${forecast['high']} / 低: ${forecast['low']}',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TenDayForecastView extends StatelessWidget {
  final String city;
  final List<Map<String, dynamic>> tenDayForecast;

  const TenDayForecastView({
    super.key,
    required this.city,
    required this.tenDayForecast,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('10 天預報 - $city')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: tenDayForecast.length,
          itemBuilder: (context, index) {
            final forecast = tenDayForecast[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.wb_sunny, // 可根據天氣狀況動態更改圖示
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('${forecast['day']}'),
                subtitle: Text('${forecast['weather']}'),
                trailing: Text('${forecast['temp']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
