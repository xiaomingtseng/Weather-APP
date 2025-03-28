import 'package:flutter/material.dart';

class SearchWeatherView extends StatelessWidget {
  final String city;
  final Function(String) onAddToHome;
  final List<String> existingCities;

  const SearchWeatherView({
    super.key,
    required this.city,
    required this.onAddToHome,
    required this.existingCities,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCityInHome = existingCities.contains(city);

    // 假資料，模擬天氣資訊
    final Map<String, dynamic> currentWeather = {
      'temperature': '22.0°C',
      'highLow': '高: 25°C / 低: 18°C',
      'location': city,
    };

    final List<Map<String, dynamic>> hourlyForecast = List.generate(
      12,
      (index) => {
        'hour': '${6 + index}:00',
        'temp': '${20 + index % 5}°C',
        'icon': Icons.wb_sunny,
      },
    );

    final List<Map<String, dynamic>> tenDayForecast = [
      {'day': '星期一', 'high': '25°C', 'low': '18°C', 'weather': '晴天'},
      {'day': '星期二', 'high': '24°C', 'low': '17°C', 'weather': '多雲'},
      {'day': '星期三', 'high': '23°C', 'low': '16°C', 'weather': '小雨'},
      {'day': '星期四', 'high': '26°C', 'low': '19°C', 'weather': '晴天'},
      {'day': '星期五', 'high': '27°C', 'low': '20°C', 'weather': '雷陣雨'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('搜尋結果 - $city')),
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
          if (!isCityInHome) // 如果城市不在主畫面中，顯示新增按鈕
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  onAddToHome(city); // 新增至主畫面
                  Navigator.of(context).pop(); // 返回主畫面
                },
                child: const Text('新增至主畫面'),
              ),
            ),
          if (isCityInHome) // 如果城市已在主畫面中，顯示提示文字
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('此城市已在主畫面中', style: TextStyle(color: Colors.grey)),
            ),
        ],
      ),
    );
  }
}
