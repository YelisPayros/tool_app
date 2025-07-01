import 'package:flutter/material.dart';
import '../services/agify_service.dart';

class AgePredictorScreen extends StatefulWidget {
  const AgePredictorScreen({super.key});

  @override
  State<AgePredictorScreen> createState() => _AgePredictorScreenState();
}

class _AgePredictorScreenState extends State<AgePredictorScreen> {
  final TextEditingController _nameController = TextEditingController();
  int? _age;
  String _category = '';
  String _imagePath = '';

  Future<void> _predictAge() async {
    final service = AgifyService();
    final age = await service.predictAge(_nameController.text.trim());
    if (age != null) {
      String category;
      String imagePath;

      if (age < 25) {
        category = 'Joven';
        imagePath = 'assets/images/joven.jpg';
      } else if (age < 60) {
        category = 'Adulto';
        imagePath = 'assets/images/adulto.jpg';
      } else {
        category = 'Anciano';
        imagePath = 'assets/images/anciano.jpeg';
      }

      setState(() {
        _age = age;
        _category = category;
        _imagePath = imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predecir Edad')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictAge,
              child: const Text('Predecir'),
            ),
            const SizedBox(height: 20),
            if (_age != null) ...[
              Text('Edad estimada: $_age años', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Categoría: $_category', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Image.asset(
                _imagePath,
                height: 150,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
