import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late final TextEditingController controller;
  int? segmentedControlValue = 0;
  String calculationResult = '';
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: controller),
          CupertinoSlidingSegmentedControl<int>(
              groupValue: segmentedControlValue,
              backgroundColor: Colors.blue.shade200,
              children: const <int, Widget>{
                0: Text('Easy'),
                1: Text('Hard'),
                2: Text('Insane')
              },
              onValueChanged: (value) {
                setState(() {
                  segmentedControlValue = value;
                });
              }),
          ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  calculationResult = makeEquation(
                      int.parse(controller.text), segmentedControlValue ?? 0);
                });
              },
              icon: const Icon(Icons.check),
              label: const Text('Calculate')),
          Text(calculationResult,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 40)),
        ],
      ),
    ));
  }

  String makeEquation(int from, int difficulty) {
    final rng = Random();
    //TODO: think about overflow 🤔
    switch (difficulty) {
      case 0:
        final a = rng.nextInt(from.ceil() * 10);
        final b = rng.nextInt(from.ceil() * 10);
        return '${a}x + $b = ${a * from + b}';
      case 1:
        final a = rng.nextInt(from.ceil() * 10);
        final b = rng.nextInt(from.ceil() * 10);
        final c = rng.nextInt(from.ceil() * 10);
        final d = rng.nextInt(from.ceil() * 10);
        final e = rng.nextInt(from.ceil() * 10);
        final result = a * pow(from, 4) +
            b * pow(from, 4) +
            c * pow(from, 3) +
            d * pow(from, 2) +
            e;
        return '${a}x^4 + ${b}x^3 + ${c}x^2 + ${d}x + $e = $result';
      case 2:
      //TODO: think of something hard
      default:
        throw Exception('Unknown difficulty');
    }
  }
}
