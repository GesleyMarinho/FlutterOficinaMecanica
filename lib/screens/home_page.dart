import 'package:flutter/material.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Oficina'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.build, size: 100.0),
            const Text(
              'Seja bem vindo a Oficina Mecânica',
              style: TextStyle(
                
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            FilledButton(
              onPressed: () {
                // lógica vai aqui
              },
              child: Text('Clientes'),
            ),
          ],
        ),
      ),
    );
  }
}
