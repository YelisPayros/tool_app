import 'package:flutter/material.dart';
import '../services/pokemon_service.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _nameController = TextEditingController();
  Map<String, dynamic>? _pokemon;

  Future<void> _searchPokemon() async {
    final service = PokemonService();
    final data = await service.fetchPokemon(_nameController.text.trim().toLowerCase());
    setState(() {
      _pokemon = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Pokémon')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre del Pokémon'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchPokemon,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            if (_pokemon != null)
              Column(
                children: [
                  Image.network(_pokemon!['sprites']['front_default']),
                  Text('Nombre: ${_pokemon!['name']}', style: const TextStyle(fontSize: 18)),
                  Text('Altura: ${_pokemon!['height']}', style: const TextStyle(fontSize: 18)),
                  Text('Peso: ${_pokemon!['weight']}', style: const TextStyle(fontSize: 18)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
