import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'weather_model.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({Key? key, required this.model}) : super(key: key);

  final WeatherModel model;

  _randomKey(Map map) => map.keys.elementAt(Random().nextInt(map.length));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'antiweather'.tr(),
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(model.name,
                    style: Theme.of(context).textTheme.headline1)),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Column(
                  children: [
                    Text('weather_welcome'.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption),
                    const SizedBox(height: 20.0),
                    InformationPair(
                        text: 'temperature'.tr(),
                        value: convertTemperature(model.main.temp)),
                    const SizedBox(height: 5.0),
                    InformationPair(
                        text: 'pressure'.tr(),
                        value: convertPressure(model.main.pressure.toDouble())),
                    const SizedBox(height: 5.0),
                    InformationPair(
                        text: 'wind_speed'.tr(),
                        value: convertSpeed(model.wind.speed)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'try_again'.tr(),
                )),
            const Spacer()
          ],
        ),
      ),
    );
  }

  String convertTemperature(double temp) {
    final Map<String, double> variants = {
      'sun'.tr(): 5778.0,
      'moon'.tr(): 26.0,
      'iron'.tr(): 473.15,
      'cat'.tr(): 311.5
    };

    final key = _randomKey(variants);
    final value = variants[key]!;

    return (temp / value).toStringAsFixed(2) + 'of'.tr() + key + 'ttemp'.tr();
  }

  String convertSpeed(double speed) {
    final Map<String, double> variants = {
      'butterfly'.tr(): 13.4112,
      'michael_phelps'.tr(): 2.10109,
      'lion'.tr(): 22.2222
    };

    final key = _randomKey(variants);
    final value = variants[key]!;

    return (speed / value).toStringAsFixed(2) + 'of'.tr() + key + 'speed'.tr();
  }

  String convertPressure(double pressure) {
    final Map<String, double> variants = {
      'juice'.tr(): 1020.0,
      'mlk'.tr(): 1030.0,
      'ooil'.tr(): 800.0
    };

    final key = _randomKey(variants);
    final value = variants[key]!;

    double mmHgUnit = 133.322;
    double mmHg = pressure * 0.75;
    double coeff = mmHgUnit / (value * 9.8 * 0.001);

    return (mmHg * coeff).toStringAsFixed(2) + 'mm'.tr() + key + 'column'.tr();
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
      Text(text, style: Theme.of(context).textTheme.bodyText1),
      const SizedBox(width: 10.0),
      Text(value, style: Theme.of(context).textTheme.bodyText2),
    ]);
  }
}
