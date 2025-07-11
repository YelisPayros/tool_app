import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/gender_predictor_screen.dart';
import 'screens/age_predictor_screen.dart';
import 'screens/universities_screen.dart';
import 'screens/weather_screen.dart';
import 'screens/pokemon_screen.dart';
import 'screens/wordpress_screen.dart';
import 'screens/about_screen.dart';
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
      '/universities': (context) => const UniversitiesScreen(),
      '/weather': (context) => const WeatherScreen(),
      '/pokemon': (context) => const PokemonScreen(),
      '/wordpress': (context) => const WordPressNewsScreen(),
      '/about': (context) => const AboutScreen(),
    },
    );
  }
}