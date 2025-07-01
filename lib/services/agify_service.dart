import 'dart:convert';
import 'package:http/http.dart' as http;

class AgifyService {
  Future<int?> predictAge(String name) async {
    final url = Uri.parse('https://api.agify.io/?name=$name');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['age'];
    } else {
      return null;
    }
  }
}
