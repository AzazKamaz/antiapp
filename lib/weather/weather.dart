import 'dart:math';

import 'package:antiapp/weather/weather_api.dart';
import 'package:flutter/material.dart';
import 'weather_details.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _Weather();
}

class _Weather extends State<Weather> {
  final _searchController = TextEditingController();
  final _client = WeatherApi();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AntiWeather')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Spacer(),
          TextField(
              controller: _searchController,
              decoration: const InputDecoration(hintText: 'City name')),
          const SizedBox(height: 16.0),
          const Text(
            "It's simple. Type in the name of the city, and I won't show you anything useful. I hope you are over 18.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12.0),
          OutlinedButton.icon(
              onPressed: () {
                var cityName = _searchController.text;
                if (cityName.isNotEmpty) {
                  _getWeather(cityName);
                }
              },
              icon: const Icon(Icons.search),
              label: const Text('Search')),
          const Spacer(),
        ]),
      ),
    );
  }

  void _getWeather(String cityName) {
    _client.getWeather(cityName).then((model) {
      if (model != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WeatherDetails(model: model)));
      } else {
        _displayNetworkError();
      }
    });
  }

  void _displayNetworkError() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred while searching. Try another city.')));
  }
}
