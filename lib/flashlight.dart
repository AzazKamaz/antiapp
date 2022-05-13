import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Flashlight extends StatefulWidget {
  const Flashlight({Key? key}) : super(key: key);

  @override
  State<Flashlight> createState() => _FlashlightState();
}

class _FlashlightState extends State<Flashlight> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('press_anywhere'.tr())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Builder(builder: (context) {
        return GestureDetector(onTap: () => Navigator.of(context).pop());
      }),
    );
  }
}
