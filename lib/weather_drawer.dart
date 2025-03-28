import 'package:flutter/material.dart';

class WeatherDrawer extends StatelessWidget {
  final Function(String) onSearch;

  const WeatherDrawer({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String searchInput = '';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Text(
              '天氣選單',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('搜尋城市'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('搜尋城市'),
                    content: TextField(
                      onChanged: (value) => searchInput = value,
                      decoration: const InputDecoration(hintText: '輸入城市名稱'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('取消'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (searchInput.isNotEmpty) {
                            onSearch(searchInput); // 呼叫搜尋功能
                          }
                        },
                        child: const Text('搜尋'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
