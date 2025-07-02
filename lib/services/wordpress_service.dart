
import 'dart:convert';
import 'package:http/http.dart' as http;

class WordPressService {
  final String baseUrl;

  WordPressService({required this.baseUrl});

  Future<List<Map<String, dynamic>>> fetchLatestPosts() async {
    final url = Uri.parse('$baseUrl/wp-json/wp/v2/posts?per_page=3');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((post) => {
        'title': post['title']['rendered'],
        'excerpt': post['excerpt']['rendered'],
        'link': post['link'],
      }).toList();
    } else {
      throw Exception('Error fetching WordPress posts');
    }
  }
}