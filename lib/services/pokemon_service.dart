import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  Future<Map<String, dynamic>> fetchPokemon(String name) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$name');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Pokemon not found');
    }
  }
}
