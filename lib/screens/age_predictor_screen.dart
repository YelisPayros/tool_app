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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Predecir Edad',
          style: TextStyle( color: Colors.white)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF42A5F5),
              Color(0xFF0D47A1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.cake, size: 80, color: Colors.white),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _nameController,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person, color: Colors.white),
                              labelText: 'Nombre',
                              hintText: 'Escribe tu nombre',
                              hintStyle: const TextStyle(color: Colors.white70),
                              labelStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.search),
                            label: const Text('Predecir'),
                            onPressed: _predictAge,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade800,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              textStyle: const TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                          ),
                          const SizedBox(height: 30),
                          if (_age != null) ...[
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 8,
                              color: Colors.white.withOpacity(0.9),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      'Edad estimada: $_age años',
                                      style: const TextStyle(fontSize: 22, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Categoría: $_category',
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 20),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        _imagePath,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
