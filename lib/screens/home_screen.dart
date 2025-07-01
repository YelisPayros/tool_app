import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Predecir Género'),
                onTap: () => Navigator.pushNamed(context, '/gender'),
              ),
              ListTile(
                leading: const Icon(Icons.cake),
                title: const Text('Predecir Edad'),
                onTap: () => Navigator.pushNamed(context, '/age'),
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text('Universidades'),
                onTap: () => Navigator.pushNamed(context, '/universities'),
              ),
              ListTile(
                leading: const Icon(Icons.cloud),
                title: const Text('Clima en RD'),
                onTap: () => Navigator.pushNamed(context, '/weather'),
              ),
              ListTile(
                leading: const Icon(Icons.catching_pokemon),
                title: const Text('Pokémon Info'),
                onTap: () => Navigator.pushNamed(context, '/pokemon'),
              ),
              ListTile(
                leading: const Icon(Icons.web),
                title: const Text('Noticias WordPress'),
                onTap: () => Navigator.pushNamed(context, '/wordpress'),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Acerca de'),
                onTap: () => Navigator.pushNamed(context, '/about'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1565C0), // Azul oscuro
              Color(0xFF42A5F5), // Azul medio
              Color(0xFF81D4FA), // Azul claro
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Tool App',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tu caja de herramientas todo en uno para predicciones, clima, Pokémon y más.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                const Icon(
                  Icons.build,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 60),
                ElevatedButton.icon(
                  icon: const Icon(Icons.menu),
                  label: const Text('Menú'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.85),
                    foregroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 18,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () => _showMenu(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
