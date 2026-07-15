import 'package:flutter/material.dart';
import 'package:flutter_oficina/features/models/domain/veiculo_model.dart';

class DetalhesVeiculoScreen extends StatelessWidget {
  final VeiculosModel veiculo;

  const DetalhesVeiculoScreen({super.key, required this.veiculo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do veiculo')),

      body: Text(veiculo.modelo ?? 'Modelo não informado'),
    );
  }
}
