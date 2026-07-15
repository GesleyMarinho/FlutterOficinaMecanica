import 'package:flutter/material.dart';
import 'package:flutter_oficina/features/veiculos/repository/veiculo_repository.dart';
import 'package:flutter_oficina/features/models/domain/veiculo_model.dart';

import '../../../core/errors/veiculo_validation_exception.dart';

class FormVeiculoScreen extends StatefulWidget {
  final String clienteId;

  const FormVeiculoScreen({super.key, required this.clienteId});

  @override
  State<FormVeiculoScreen> createState() => _FormVeiculosScreen();
}

class _FormVeiculosScreen extends State<FormVeiculoScreen> {
  VeiculoRepository veiculoRepository = VeiculoRepository();

  final _placaCtrl = TextEditingController();
  final _corCtrl = TextEditingController();
  final _modeloCtrl = TextEditingController();
  final _anoCtrl = TextEditingController();
  final _kmCtrl = TextEditingController();

  @override
  void dispose() {
    _placaCtrl.dispose();
    _corCtrl.dispose();
    _modeloCtrl.dispose();
    _anoCtrl.dispose();
    _kmCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvarDadosVeiculo() async {
    try {
      final ano = int.tryParse(_anoCtrl.text);
      if (ano == null) {
        throw VeiculoValidationException('Ano deve ser um numero');
      }
      final km = double.tryParse(_kmCtrl.text);
      if (km == null) {
        throw VeiculoValidationException('Quilometragem deve ser um numero');
      }

      final veiculo = VeiculosModel(
        clienteId: widget.clienteId,
        placa: _placaCtrl.text,
        cor: _corCtrl.text,
        modelo: _modeloCtrl.text,
        ano: ano,
        quilomentragem: km,
      );
      await veiculoRepository.salvarVeiculos(veiculo);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Veiculo'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _placaCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Placa',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _corCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'cor',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _modeloCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Modelo',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _anoCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ano',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _kmCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'KM',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton.icon(
              onPressed: () {
                _salvarDadosVeiculo();
              },
              icon: Icon(Icons.save),
              label: const Text('Salvar'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
