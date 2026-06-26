import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/favorites_provider.dart';
import 'providers/booking_provider.dart';
import 'screens/splash/splash_screen.dart';
import 'providers/station_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              FavoritesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              BookingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              StationProvider(),
        ),
      ],
      child: const ChargeMateApp(),
    ),
  );
}

class ChargeMateApp extends StatelessWidget {
  const ChargeMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChargeMate',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const SplashScreen(),
    );
  }
}