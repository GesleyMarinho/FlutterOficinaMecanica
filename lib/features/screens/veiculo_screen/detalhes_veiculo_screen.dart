import 'package:flutter/material.dart';
import 'package:flutter_oficina/features/models/domain/veiculo_model.dart';

import '../../models/domain/orderServico_model.dart';
import '../../veiculos/repository/ordem_servico_repository.dart';

class ListOrdemServicoScreen extends StatefulWidget {
  final VeiculosModel veiculosModel;

  const ListOrdemServicoScreen({super.key, required this.veiculosModel});

  @override
  State<ListOrdemServicoScreen> createState() => _ListOrdemServicoScreen();
}

class _ListOrdemServicoScreen extends State<ListOrdemServicoScreen> {
  final OrdemServicoRepository _repository = OrdemServicoRepository();
  List<OrdemServicoModel> _ordens = [];

  Future<void> _carregarOrdens() async {
    final veiculoId = widget.veiculosModel.veiculoId;

    if (veiculoId == null || veiculoId.isEmpty) {
      return;
    }

    final lista = await _repository.listarPorVeiculo(veiculoId);

    setState(() {
      _ordens = lista;
    });
  }

  @override
  void initState() {
    super.initState();
    _carregarOrdens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cliente',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Informações cadastrais',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _ordens.isEmpty
            ? const Center(
                child: Text('Nenhuma ordem de serviço para esse veiculo'),
              )
            : ListView.builder(
                itemCount: _ordens.length,
                itemBuilder: (context, index) {
                  final ordem = _ordens[index];
                  return Card(
                    child: ListTile(
                      title: Text(ordem.descricaoProblema),
                      subtitle: Text('Status: ${ordem.status}'),
                      trailing: Text('R\$ ${ordem.total.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
