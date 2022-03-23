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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Press anywhere to go back')));
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
