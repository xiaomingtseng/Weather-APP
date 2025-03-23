import 'package:flutter/material.dart';
import 'weather_detail_page.dart';

class WeatherListPage extends StatefulWidget {
  const WeatherListPage({super.key});

  @override
  _WeatherListPageState createState() => _WeatherListPageState();
}

class _WeatherListPageState extends State<WeatherListPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _locations = ['台北']; // 初始地區
  final List<String> _searchResults = [];

  void _searchLocation(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _searchResults.add(query);
        _searchController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('天氣列表')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '搜尋地區',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchLocation(_searchController.text),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _locations.length + _searchResults.length,
              itemBuilder: (context, index) {
                final location =
                    index < _locations.length
                        ? _locations[index]
                        : _searchResults[index - _locations.length];
                return Card(
                  child: ListTile(
                    title: Text(location),
                    subtitle: const Text('點擊查看詳細天氣'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => WeatherDetailPage(city: location),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
