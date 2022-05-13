import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/services.dart';

void webDownload() async {
  final rawData =
      (await rootBundle.load('assets/replacement.png')).buffer.asUint8List();
  final content = base64Encode(rawData);
  final _ = AnchorElement(
      href: 'data:application/octet-stream;charset=utf-16le;base64,$content')
    ..setAttribute('download', 'image.png')
    ..click();
}
