import 'package:flutter/material.dart';
import 'package:flutter_oficina/features/models/domain/orderServico_model.dart';
import 'package:flutter_oficina/features/veiculos/repository/ordem_servico_repository.dart';
import '../../../core/errors/order_servico_validation_exception.dart';
import '../../models/domain/cliente_model.dart';
import '../../models/domain/veiculo_model.dart';

class FormOrdemServicoScreen extends StatefulWidget {
  final VeiculosModel veiculo;
  final ClienteModel cliente;

  const FormOrdemServicoScreen({
    super.key,
    required this.veiculo,
    required this.cliente,
  });

  @override
  State<FormOrdemServicoScreen> createState() => _FormOrdemServicoScreen();
}

class _FormOrdemServicoScreen extends State<FormOrdemServicoScreen> {
  final OrdemServicoRepository _ordemServicoRepository =
      OrdemServicoRepository();

  final TextEditingController _descricaoCtrl = TextEditingController();
  final TextEditingController _maoDeObraCtrl = TextEditingController();
  final TextEditingController _pecasCtrl = TextEditingController();

  @override
  void dispose() {
    _descricaoCtrl.dispose();
    _maoDeObraCtrl.dispose();
    _pecasCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de ordem de servico"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _pecasCtrl,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Valor dos produtos",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _maoDeObraCtrl,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Valor mão de Obra",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _descricaoCtrl,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Descrição da ordem de serviço",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await salvarOrdemDeServico();
                },
                child: const Text("Salvar"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> salvarOrdemDeServico() async {
    try {
      final veiculoId = widget.veiculo.veiculoId;
      if (veiculoId == null || veiculoId.isEmpty) {
        throw OrderServicoValidationException('Veiculo sem ID');
      }

      final clienteId = widget.cliente.id;
      if (clienteId == null || clienteId.isEmpty) {
        throw OrderServicoValidationException('Cliente sem ID');
      }

      final valorMaoDeObra = double.tryParse(_maoDeObraCtrl.text);
      if (valorMaoDeObra == null) {
        throw OrderServicoValidationException('Valor de mao de obra invalido');
      }

      final valorPecas = double.tryParse(_pecasCtrl.text);
      if (valorPecas == null) {
        throw OrderServicoValidationException('Valor de pecas invalido');
      }

      final ordemServicoModel = OrdemServicoModel(
        veiculoId: veiculoId,
        clienteId: clienteId,
        dataEntrada: DateTime.now(),
        status: 'aberta',
        descricaoProblema: _descricaoCtrl.text,
        valorMaoDeObra: valorMaoDeObra,
        valorPecas: valorPecas,
      );

      await _ordemServicoRepository.salvarOrdemServico(ordemServicoModel);

      _maoDeObraCtrl.clear();
      _descricaoCtrl.clear();
      _pecasCtrl.clear();

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception', '.'))),
        );
      }
    }
  }
}
