import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showAntiAboutDialog(BuildContext context) {
  const contacts = ['azazkamaz', 'glebosotov', 'igooor_bb', 'curlykorine'];

  showAboutDialog(
    context: context,
    children: contacts.map((contact) {
      final backgroundColor =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5);

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
  );
}
