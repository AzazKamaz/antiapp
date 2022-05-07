import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'settings_animation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _button() {
    return InkWell(
      splashColor: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white,
      onTap: () {
        ThemeProvider.controllerOf(context).nextTheme();
      },
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
                  Color.lerp(
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      Colors.black,
                      .05)!
                ],
              ),
            ),
            child: ScaleTransition(
                scale: Tween(begin: 0.95, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const CurveWave(),
                  ),
                ),
                child: Icon(
                  Icons.brightness_high,
                  size: 100,
                  color: Theme.of(context).colorScheme.inversePrimary,
                )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.inverseSurface),
          onPressed: () {
            Navigator.pop(context);
          }),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      body: Center(
        child: CustomPaint(
          painter: CirclePainter(
            _controller,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 4.125,
            height: MediaQuery.of(context).size.height * 4.125,
            child: _button(),
          ),
        ),
      ),
    );
  }
}
