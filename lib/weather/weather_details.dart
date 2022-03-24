import 'dart:math';

import 'package:flutter/material.dart';
import 'weather_model.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({Key? key, required this.model}) : super(key: key);

  final WeatherModel model;

  _randomKey(Map map) => map.keys.elementAt(Random().nextInt(map.length));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('AntiWeather')),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Spacer(),
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(model.name,
                      style: Theme.of(context).textTheme.headline1)),
              Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(children: [
                    Text(
                        "Here's the weather in your town in units you don't want to see in this life. You're fucking welcome:",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption),
                    const SizedBox(height: 20.0),
                    InformationPair(
                        text: 'Temperature',
                        value: convertTemperature(model.main.temp)),
                    const SizedBox(height: 5.0),
                    InformationPair(
                        text: 'Pressure',
                        value: convertPressure(model.main.pressure.toDouble())),
                    const SizedBox(height: 5.0),
                    InformationPair(
                        text: 'Wind speed',
                        value: convertSpeed(model.wind.speed)),
                  ])),
              const SizedBox(height: 10.0),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Try again')),
              const Spacer()
            ])));
  }

  String convertTemperature(double temp) {
    final Map<String, double> variants = {
      'the Sun': 5778.0,
      'the Moon': 26.0,
      'an iron': 473.15,
      'a cat': 311.5
    };

    final key = _randomKey(variants);
    final value = variants[key]!;

    return (temp / value).toStringAsFixed(2) + ' of ' + key + ' temperature';
  }

  String convertSpeed(double speed) {
    final Map<String, double> variants = {
      'a butterfly': 13.4112,
      'Michael Phelps': 2.10109,
      'a lion': 22.2222
    };

    final key = _randomKey(variants);
    final value = variants[key]!;

    return (speed / value).toStringAsFixed(2) + ' of ' + key + ' speed';
  }

  String convertPressure(double pressure) {
    final Map<String, double> variants = {
      'orange juice': 1020.0,
      'milk': 1030.0,
      'oil': 800.0
    };

    final key = _randomKey(variants);
    final value = variants[key]!;

    double mmHgUnit = 133.322;
    double mmHg = pressure * 0.75;
    double coeff = mmHgUnit / (value * 9.8 * 0.001);

    return (mmHg * coeff).toStringAsFixed(2) + ' mm of ' + key + ' column';
  }
}

class InformationPair extends StatelessWidget {
  const InformationPair({Key? key, required this.text, required this.value})
      : super(key: key);

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(text, style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(width: 10.0),
      Text(value, style: Theme.of(context).textTheme.bodyMedium),
    ]);
  }
}
