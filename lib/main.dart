import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/gender_predictor_screen.dart';
import 'screens/age_predictor_screen.dart';
import 'screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Toolbox App',
        theme: ThemeData(primarySwatch: Colors.blue),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeScreen(),
      '/gender': (context) => const GenderPredictorScreen(),
      '/age': (context) => const AgePredictorScreen(),
      '/weather': (context) => const WeatherScreen(),
    },
    );
  }
}