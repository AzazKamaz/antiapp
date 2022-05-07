import 'dart:math';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; 
import '../translations/locale_keys.g.dart';

import 'weather_model.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({Key? key, required this.model}) : super(key: key);

  final WeatherModel model;

  _randomKey(Map map) => map.keys.elementAt(Random().nextInt(map.length));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.antiweather.tr(),)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            //TODO(igoor_bb) add picture here
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(model.name,
                    style: Theme.of(context).textTheme.headline1)),
            Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Column(children: [
                  Text(
                      LocaleKeys.weather_welcome.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption),
                  const SizedBox(height: 20.0),
                  InformationPair(
                      text: LocaleKeys.temperature.tr(),
                      value: convertTemperature(model.main.temp)),
                  const SizedBox(height: 5.0),
                  InformationPair(
                      text: LocaleKeys.pressure.tr(),
                      value: convertPressure(model.main.pressure.toDouble())),
                  const SizedBox(height: 5.0),
                  InformationPair(
                      text: LocaleKeys.wind_speed.tr(),
                      value: convertSpeed(model.wind.speed)),
                ])),
            const SizedBox(height: 10.0),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(LocaleKeys.try_again.tr(),)),
            const Spacer()
          ],
        ),
      ),
    );
  }

  String convertTemperature(double temp) {
    final Map<String, double> variants = {
      LocaleKeys.sun.tr(): 5778.0,
      LocaleKeys.moon.tr(): 26.0,
      LocaleKeys.iron.tr(): 473.15,
      LocaleKeys.cat.tr(): 311.5
    };

    final key = _randomKey(variants);
    final value = variants[key]!;

    return (temp / value).toStringAsFixed(2) + LocaleKeys.of.tr() + key + LocaleKeys.ttemp.tr();
  }

  String convertSpeed(double speed) {
    final Map<String, double> variants = {
      LocaleKeys.butterfly.tr(): 13.4112,
      LocaleKeys.michael_phelps.tr(): 2.10109,
      LocaleKeys.lion.tr(): 22.2222
    };

    final key = _randomKey(variants);
    final value = variants[key]!;

    return (speed / value).toStringAsFixed(2) + LocaleKeys.of.tr() + key + LocaleKeys.speed.tr();
  }

  String convertPressure(double pressure) {
    final Map<String, double> variants = {
      LocaleKeys.juice.tr(): 1020.0,
      LocaleKeys.mlk.tr(): 1030.0,
      LocaleKeys.ooil.tr(): 800.0
    };

    final key = _randomKey(variants);
    final value = variants[key]!;

    double mmHgUnit = 133.322;
    double mmHg = pressure * 0.75;
    double coeff = mmHgUnit / (value * 9.8 * 0.001);

    return (mmHg * coeff).toStringAsFixed(2) + LocaleKeys.mm.tr() + key + LocaleKeys.column.tr();
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
