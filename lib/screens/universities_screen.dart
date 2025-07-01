import 'package:flutter/material.dart';
import '../services/university_service.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  final TextEditingController _countryController = TextEditingController();
  List<Map<String, dynamic>> _universities = [];

  Future<void> _searchUniversities() async {
    final service = UniversityService();
    final universities = await service.fetchUniversities(_countryController.text.trim());
    setState(() {
      _universities = universities;
    });
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Universidades')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(labelText: 'País'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchUniversities,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  final uni = _universities[index];
                  return ListTile(
                    title: Text(uni['name']),
                    subtitle: Text(uni['web_page']),
                    onTap: () => _launchUrl(uni['web_page']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
