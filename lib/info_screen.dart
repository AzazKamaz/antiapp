import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);
  static const contacts = [
    'azazkamaz',
    'glebosotov',
    'igooor_bb',
    'curlykorine'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      AboutDialog(
        children: contacts.map((contact) {
          final backgroundColor =
              Color((Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.5);

          return GestureDetector(
            onTap: () async {
              final url = Uri.parse('https://t.me/$contact');
              if (await canLaunchUrl(url)) {
                launchUrl(url);
              }
            },
            child: Chip(
              backgroundColor: backgroundColor,
              label: Text(contact),
            ),
          );
        }).toList(),
      )
    ]));
  }
}
