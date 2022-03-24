import 'package:antiapp/weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';

import '/calculator.dart';
import '/flashlight.dart';
import '/calendar.dart';
import '/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const AntiApp());
}

class AntiApp extends StatelessWidget {
  const AntiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AntiApp',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const AppListPage(),
    );
  }
}

class AppListPage extends StatefulWidget {
  const AppListPage({Key? key}) : super(key: key);

  @override
  State<AppListPage> createState() => _AppListPageState();
}

class _AppListPageState extends State<AppListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('AntiApp')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Calculator()));
                  },
                  icon: const Icon(Icons.abc),
                  label: const Text('AntiCalculator')),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Flashlight()));
                  },
                  icon: const Icon(Icons.flashlight_off),
                  label: const Text('AntiFlashlight')),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Weather()));
                  },
                  icon: const Icon(Icons.cloud_off),
                  label: const Text('AntiWeather')),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Calendar()));
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('AntiCalendar')),
              ElevatedButton.icon(
                  onPressed: () async {
                    var cams = await availableCameras();
                    if (cams.isNotEmpty) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TakePictureScreen(
                                camera: cams.first,
                              )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No camera found')));
                    }
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('AntiCamera')),
            ],
          ),
        ));
  }
}
