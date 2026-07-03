import 'package:flutter/material.dart';
import 'package:flutter_oficina/features/models/domain/cliente_model.dart';

class DetalhesClienteScreen extends StatefulWidget {
  const DetalhesClienteScreen({super.key, required ClienteModel cliente});

  State<DetalhesClienteScreen> createState() => _DetalhesClienteScreen();
}

class _DetalhesClienteScreen extends State<DetalhesClienteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Text('Vamos fazer os detalhes amanhã !!!'));
    throw UnimplementedError();
  }
}
