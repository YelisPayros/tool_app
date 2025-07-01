import 'dart:convert';
import 'package:http/http.dart' as http;

class UniversityService {
  Future<List<Map<String, dynamic>>> fetchUniversities(String country) async {
    final url = Uri.parse('http://universities.hipolabs.com/search?country=$country');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((u) => {
        'name': u['name'],
        'web_page': u['web_pages'][0],
        'domain': u['domains'][0],
      }).toList();
    } else {
      throw Exception('Error fetching universities');
    }
  }
}
