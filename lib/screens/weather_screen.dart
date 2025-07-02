import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? _weather;

  Future<void> _loadWeather() async {
    final service = WeatherService();
    final weather = await service.fetchWeather();
    setState(() {
      _weather = weather['current_weather'];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }


  IconData getWeatherIcon(double temp) {
    if (temp >= 30) {
      return Icons.wb_sunny; // Muy soleado
    } else if (temp >= 20) {
      return Icons.cloud; // Parcialmente nublado
    } else if (temp >= 10) {
      return Icons.wb_cloudy; // Nublado
    } else {
      return Icons.ac_unit; // Frío
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Clima en RD',
            style: TextStyle( color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF42A5F5),
              Color(0xFF0D47A1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: _weather == null
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : SafeArea(
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.white.withOpacity(0.9),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Santo Domingo',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Icon(
                      getWeatherIcon(_weather!['temperature']),
                      size: 80,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_weather!['temperature']} °C',
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Viento: ${_weather!['windspeed']} km/h',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Dirección: ${_weather!['winddirection']}°',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
