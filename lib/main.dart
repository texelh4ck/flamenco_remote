import 'package:device_preview/device_preview.dart';
import 'package:flamenco_remote/providers/preferences.dart';
import 'package:flamenco_remote/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(DevicePreview(
    enabled: false,
    isToolbarVisible: false,
    builder: (BuildContext context) => const MainApp(),
    backgroundColor: Colors.black,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
      ),
      routes: RouterApp.genRoutes(),
      initialRoute: RouterApp.getInitialRoute(),
    );
  }
}
