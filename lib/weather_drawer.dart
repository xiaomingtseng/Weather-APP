import 'package:flutter/material.dart';

class WeatherDrawer extends StatefulWidget {
  const WeatherDrawer({super.key});

  @override
  WeatherDrawerState createState() => WeatherDrawerState();
}

class WeatherDrawerState extends State<WeatherDrawer> {
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
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Center(
              child: Text(
                '搜尋地區',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '輸入地區名稱',
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
                return ListTile(
                  title: Text(location),
                  onTap: () {
                    // 點擊後可切換到該地區的天氣資訊
                    Navigator.pop(context); // 關閉 Drawer
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
