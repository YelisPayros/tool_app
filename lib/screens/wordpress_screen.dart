import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/wordpress_service.dart';

class WordPressNewsScreen extends StatefulWidget {
  const WordPressNewsScreen({super.key});

  @override
  State<WordPressNewsScreen> createState() => _WordPressNewsScreenState();
}

class _WordPressNewsScreenState extends State<WordPressNewsScreen> {
  late Future<List<Map<String, dynamic>>> _posts;

  @override
  void initState() {
    super.initState();
    _posts = WordPressService(baseUrl: 'https://www.rollingstone.com').fetchLatestPosts();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ Fondo blanco limpio
      appBar: AppBar(
        title: const Text('Noticias Rolling Stone'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/rollingstone_logo.png',
            height: 80,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: _posts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay noticias.'));
                }

                final posts = snapshot.data!;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post['excerpt'].replaceAll(RegExp(r'<[^>]*>'), ''),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.black87),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                onPressed: () => _launchUrl(post['link']),
                                icon: const Icon(Icons.open_in_new),
                                label: const Text('Visitar'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade800,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
