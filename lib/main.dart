import 'dart:async';
import 'dart:math';

import 'package:antiapp/notes/notes_screen.dart';
import 'package:antiapp/settings.dart';
import 'package:antiapp/text_inverter.dart';
import 'package:antiapp/weather/weather.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
// delete if not needed
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_provider/theme_provider.dart';

import '/calendar.dart';
import '/camera.dart';
import '/flashlight.dart';
import './translations/codegen_loader.g.dart';
import './translations/locale_keys.g.dart';
import 'calculator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: const AntiApp()),
  );
}

class AntiApp extends StatelessWidget {
  const AntiApp({Key? key}) : super(key: key);

  static ThemeData theme = ThemeData(
    splashFactory: InkRipple.splashFactory,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    )),
  );

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: [
        AppTheme(
          id: 'light',
          data: theme,
          description: 'light theme',
        ),
        AppTheme(
          id: 'dark',
          data: ThemeData.dark().copyWith(
            splashFactory: InkRipple.splashFactory,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            )),
          ),
          description: 'dark theme',
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: LocaleKeys.antiapp.tr(),
            theme: ThemeProvider.themeOf(themeContext).data,
            home: const AppListPage(),
          ),
        ),
      ),
    );
  }
}

class AppListPage extends StatefulWidget {
  const AppListPage({Key? key}) : super(key: key);

  @override
  State<AppListPage> createState() => _AppListPageState();
}

class _AppListPageState extends State<AppListPage> {
  AudioPlayer audioPlayer = AudioPlayer();

  _playLocal() async {
    AudioCache player = AudioCache();
    const alarmAudioPath = 'sound.mp3';
    player.play(alarmAudioPath);
  }

  late Timer _timer;

  void startTimer() {
    const duration = Duration(seconds: 60);
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        Random r = Random();
        double falseProbability = .9;
        if (r.nextDouble() > falseProbability) {
          _playLocal();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  static const iconSize = 36.0;
  @override
  Widget build(BuildContext context) {
    final Map<Icon, void Function()> _apps = {
      const Icon(Icons.calculate, size: iconSize): () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Calculator()),
        );
      },
      const Icon(Icons.flashlight_off, size: iconSize): () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Flashlight()),
        );
      },
      const Icon(Icons.cloud_off, size: iconSize): () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Weather()),
        );
      },
      const Icon(Icons.calendar_month, size: iconSize): () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Calendar()),
        );
      },
      const Icon(Icons.notes, size: iconSize): () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NotesScreen()),
        );
      },
      const Icon(Icons.translate, size: iconSize): () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const TextInverter()),
        );
      },
      const Icon(Icons.camera_alt, size: iconSize): () async {
        var cams = await availableCameras();
        if (cams.isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TakePictureScreen(
                    camera: cams.first,
                  )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            LocaleKeys.no_camera_found.tr(),
          )));
        }
      },
      const Icon(Icons.settings, size: iconSize): () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
      },
    };
    return Scaffold(
        appBar: AppBar(
            title: Text(
          LocaleKeys.antiapp.tr(),
        )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2.5,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemCount: _apps.length,
            itemBuilder: (context, index) => ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color((Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0))),
                child: _apps.keys.toList()[index],
                onPressed: _apps.values.toList()[index]),
          ),
        ));
  }
}
