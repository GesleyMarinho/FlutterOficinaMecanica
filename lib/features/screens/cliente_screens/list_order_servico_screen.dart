import 'package:flutter/material.dart';
import 'package:flutter_oficina/features/models/domain/cliente_model.dart';
import '../../models/domain/veiculo_model.dart';
import '../veiculo_screen/form_ordem_servico_screen.dart';
import '../veiculo_screen/form_veiculo_screen.dart';
import '../../veiculos/repository/veiculo_repository.dart';
import '../veiculo_screen/detalhes_veiculo_screen.dart';

class DetalhesClienteScreen extends StatefulWidget {
  final ClienteModel cliente;

  const DetalhesClienteScreen({super.key, required this.cliente});

  @override
  State<DetalhesClienteScreen> createState() => _DetalhesClienteScreenState();
}

class _DetalhesClienteScreenState extends State<DetalhesClienteScreen> {
  VeiculoRepository veiculoRepository = VeiculoRepository();
  List<VeiculosModel> _listVeiculos = [];

  @override
  void initState() {
    super.initState();
    _carregarVeiculos();
  }

  Future<void> _adicionarVeiculo() async {
    final clienteId = widget.cliente.id;

    if (clienteId == null || clienteId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente sem ID para cadastrar veiculo')),
      );
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormVeiculoScreen(clienteId: clienteId),
      ),
    );

    await _carregarVeiculos();
  }

  Future<void> _carregarVeiculos() async {
    final clienteId = widget.cliente.id;
    if (clienteId == null || clienteId.isEmpty) {
      return;
    }
    final lista = await veiculoRepository.listarVeiculosPorCliente(clienteId);
    setState(() {
      _listVeiculos = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cliente = widget.cliente;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do cliente'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cliente.nome,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    _InfoCliente(label: 'Telefone', value: cliente.telefone),
                    _InfoCliente(
                      label: 'Email',
                      value: cliente.email?.isNotEmpty == true
                          ? cliente.email!
                          : 'Nao informado',
                    ),
                    _InfoCliente(
                      label: 'Cadastro',
                      value: _formatarData(cliente.dataCadastro),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _adicionarVeiculo,
              icon: const Icon(Icons.directions_car),
              label: const Text('Adicionar veiculo'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _listVeiculos.isEmpty
                  ? const Text('Nenhum veiculo cadastrado')
                  : ListView.builder(
                      itemCount: _listVeiculos.length,
                      itemBuilder: (context, index) {
                        final veiculo = _listVeiculos[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.directions_car),
                            ),
                            title: Text(
                              veiculo.modelo ?? 'Modelo nao informado',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text('Placa: ${veiculo.placa}'),
                                Text('Ano: ${veiculo.ano}'),
                                Text('Cor: ${veiculo.cor}'),
                                Text('KM: ${veiculo.quilomentragem}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  tooltip: 'Nova Ordem de serviço',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FormOrdemServicoScreen(
                                              veiculo: veiculo,
                                              cliente: widget.cliente,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                                const Icon(Icons.chevron_right),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => (ListOrdemServicoScreen(
                                    veiculosModel: veiculo,
                                  )),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();

    return '$dia/$mes/$ano';
  }
}

class _InfoCliente extends StatelessWidget {
  final String label;
  final String value;

  const _InfoCliente({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
