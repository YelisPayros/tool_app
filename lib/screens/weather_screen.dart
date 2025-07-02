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
      _weather = weather['current_weather']; // ✅ Clave correcta
    });
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clima en RD')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _weather == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ciudad: Santo Domingo',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(
                'Temperatura: ${_weather!['temperature']} °C',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(
                'Viento: ${_weather!['windspeed']} km/h',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(
                'Dirección: ${_weather!['winddirection']}°',
                style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
