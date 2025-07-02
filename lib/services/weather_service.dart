import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>> fetchWeather() async {
    final double latitude = 18.5;   // Santo Domingo, RD
    final double longitude = -69.9;

    final url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast'
            '?latitude=$latitude&longitude=$longitude&current_weather=true'
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error fetching weather: ${response.statusCode}');
    }
  }
}
