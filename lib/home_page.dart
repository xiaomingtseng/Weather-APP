import 'package:flutter/material.dart';
import 'weather_data_source.dart';
import 'weather_model.dart';
import 'weather_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WeatherData> displayedWeatherData = [weatherDataList.first]; // 初始只有台北
  WeatherData? searchResult; // 搜尋結果

  void _searchCity(String query) {
    final result = weatherDataList.firstWhere(
      (weather) => weather.city.contains(query),
      orElse:
          () => WeatherData(
            city: '未知',
            temperature: 'N/A',
            highLow: 'N/A',
            description: '找不到該城市',
            icon: Icons.error,
            hourlyForecast: [],
            dailyForecast: [],
          ),
      // 如果找不到，返回一個預設的 WeatherData 物件
    );

    setState(() {
      searchResult = result;
    });

    if (result != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => SearchResultPage(
                weather: result,
                isAdded: displayedWeatherData.contains(result),
                onAdd: () {
                  setState(() {
                    if (!displayedWeatherData.contains(result)) {
                      displayedWeatherData.add(result);
                    }
                  });
                  Navigator.of(context).pop(); // 返回主畫面
                },
              ),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('找不到該城市')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: displayedWeatherData.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('天氣查詢'),
          bottom: TabBar(
            isScrollable: true,
            tabs:
                displayedWeatherData.map((weather) {
                  return Tab(text: weather.city);
                }).toList(),
          ),
        ),
        drawer: WeatherDrawer(onSearch: _searchCity),
        body: TabBarView(
          children:
              displayedWeatherData.map((weather) {
                return WeatherDetailView(weather: weather);
              }).toList(),
        ),
      ),
    );
  }
}

class SearchResultPage extends StatelessWidget {
  final WeatherData weather;
  final bool isAdded;
  final VoidCallback onAdd;

  const SearchResultPage({
    Key? key,
    required this.weather,
    required this.isAdded,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜尋結果'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(), // 返回主畫面
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.city,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              '${weather.temperature} (${weather.highLow})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              weather.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16.0),
            if (!isAdded)
              ElevatedButton(onPressed: onAdd, child: const Text('新增至主畫面')),
          ],
        ),
      ),
    );
  }
}

class WeatherDetailView extends StatelessWidget {
  final WeatherData weather;

  const WeatherDetailView({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(weather.city, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8.0),
          Text(
            '${weather.temperature} (${weather.highLow})',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8.0),
          Text(
            weather.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16.0),
          Text('每小時預報', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weather.hourlyForecast.length,
              itemBuilder: (context, index) {
                final forecast = weather.hourlyForecast[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(forecast.icon),
                        const SizedBox(height: 4.0),
                        Text(forecast.time),
                        const SizedBox(height: 4.0),
                        Text(forecast.temperature),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Text('每日預報', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weather.dailyForecast.length,
            itemBuilder: (context, index) {
              final forecast = weather.dailyForecast[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(forecast.icon, size: 40.0),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              forecast.date,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              forecast.highLow,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              forecast.description,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
