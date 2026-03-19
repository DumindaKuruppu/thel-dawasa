import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:thel_dawasa/screens/splash_screen.dart';
import 'package:thel_dawasa/providers/theme_provider.dart';
import 'package:thel_dawasa/providers/language_provider.dart';
import 'package:thel_dawasa/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  await NotificationService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: ThelDawasaApp(cameras: cameras),
    ),
  );
}

class ThelDawasaApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const ThelDawasaApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Thel Dawasa',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: SplashScreen(cameras: cameras),
    );
  }
}
