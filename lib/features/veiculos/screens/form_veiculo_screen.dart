import 'package:flutter/material.dart';
import 'package:flutter_oficina/features/veiculos/repository/veiculo_repository.dart';
import 'package:flutter_oficina/features/models/domain/veiculo_model.dart';

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
      final veiculo = VeiculosModel(
        clienteId: widget.clienteId,
        placa: _placaCtrl.text,
        cor: _corCtrl.text,
        modelo: _modeloCtrl.text,
        ano: int.parse(_anoCtrl.text),
        quilomentragem: double.parse(_kmCtrl.text),
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
  void initState() {
    super.initState();
    _placaCtrl.text = 'abcd1234';
    _corCtrl.text = 'Vermelho';
    _modeloCtrl.text = 'Fan 160';
    _anoCtrl.text = '2016';
    _kmCtrl.text = '99.999';
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

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Placa',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _corCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'cor',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _modeloCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Modelo',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _anoCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ano',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _kmCtrl,
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
