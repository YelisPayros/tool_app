import 'package:flutter/material.dart';
import '../services/genderize_service.dart';

class GenderPredictorScreen extends StatefulWidget {
  const GenderPredictorScreen({super.key});

  @override
  State<GenderPredictorScreen> createState() => _GenderPredictorScreenState();
}

class _GenderPredictorScreenState extends State<GenderPredictorScreen> {
  final _controller = TextEditingController();
  final _service = GenderizeService();
  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predecir Género')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Ingresa un nombre'),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await _service.predictGender(_controller.text);
                setState(() => _gender = result);
              },
              child: const Text('Predecir'),
            ),
            const SizedBox(height: 20),
            if (_gender != null)
              Container(
                width: double.infinity,
                height: 200,
                color: _gender == 'male' ? Colors.blue : Colors.pinkAccent,
                child: Center(
                  child: Text(
                    'Género: $_gender',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
