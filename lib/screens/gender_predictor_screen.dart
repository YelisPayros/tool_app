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

  LinearGradient getGradient() {
    if (_gender == 'male') {
      return const LinearGradient(
        colors: [Color(0xFF42A5F5), Color(0xFF0D47A1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (_gender == 'female') {
      return const LinearGradient(
        colors: [Color(0xFFF06292), Color(0xFFAD1457)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xFF42A5F5), Color(0xFF0D47A1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  IconData getGenderIcon() {
    if (_gender == 'male') {
      return Icons.male;
    } else if (_gender == 'female') {
      return Icons.female;
    } else {
      return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Predecir Género',
            style: TextStyle( color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: getGradient(),
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
                          Icon(getGenderIcon(), size: 80, color: Colors.white),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _controller,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person, color: Colors.white),
                              labelText: 'Ingresa un nombre',
                              hintText: 'Escribe el nombre',
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
                            onPressed: () async {
                              final result = await _service.predictGender(_controller.text);
                              setState(() => _gender = result);
                            },
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
                          if (_gender != null)
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 8,
                              color: Colors.white.withOpacity(0.9),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Icon(
                                      getGenderIcon(),
                                      size: 50,
                                      color: _gender == 'male'
                                          ? Colors.blue
                                          : Colors.pinkAccent,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Género: $_gender',
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
