import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:easy_localization/easy_localization.dart';
import './translations/locale_keys.g.dart';

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
        appBar: AppBar(title: Text(LocaleKeys.anticalculator.tr(),)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary)),
                child: TeXView(
                    child: TeXViewDocument(calculationResult,
                        //TODO: width does not work
                        style: TeXViewStyle(
                            width: MediaQuery.of(context).size.width.ceil()))),
              ),
              const Spacer(),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                maxLength: 6,
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoSlidingSegmentedControl<int>(
                      groupValue: segmentedControlValue,
                      backgroundColor: Colors.blue.shade200,
                      children: <int, Widget>{
                        0: Text(LocaleKeys.easy.tr(),),
                        1: Text(LocaleKeys.hard.tr(),),
                        2: Text(LocaleKeys.insane.tr(),)
                      },
                      onValueChanged: (value) {
                        setState(() {
                          segmentedControlValue = value;
                        });
                      }),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          setState(() {
                            calculationResult = makeEquation(
                                int.parse(controller.text),
                                segmentedControlValue ?? 0);
                          });
                        }
                      },
                      icon: const Icon(Icons.check),
                      label: Text(LocaleKeys.calculate.tr(),)),
                ],
              ),
              const Spacer(),
              const Spacer(),
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
        final b = rng.nextInt(from.ceil() * 2);
        return '\$\$${a}x + $b = ${a * from + b}\$\$';
      case 1:
        final a = rng.nextInt(from.ceil() * 10);
        final b = rng.nextInt(from.ceil() * 8);
        final c = rng.nextInt(from.ceil() * 4);
        final d = rng.nextInt(from.ceil() * 2);
        final e = rng.nextInt(from.ceil());
        final result = a * pow(from, 4) +
            b * pow(from, 3) +
            c * pow(from, 2) +
            d * pow(from, 1) +
            e;
        return '\$\$${a}x^4 + ${b}x^3 + ${c}x^2 + ${d}x + $e = $result\$\$';
      case 2:
      //TODO: think of something hard
      default:
        throw Exception('Unknown difficulty');
    }
  }
}
