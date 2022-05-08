import 'package:antiapp/weather/weather_api.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
      appBar: AppBar(title: Text('antiweather'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Spacer(),
          TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'city_name'.tr(),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
              )),
          const SizedBox(height: 16.0),
          Text(
            'weather_hint'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 12.0),
          ElevatedButton.icon(
              onPressed: () {
                var cityName = _searchController.text;
                if (cityName.isNotEmpty) {
                  _getWeather(cityName);
                }
              },
              icon: const Icon(Icons.search),
              label: Text('search'.tr())),
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
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('weather_error'.tr())));
  }
}
