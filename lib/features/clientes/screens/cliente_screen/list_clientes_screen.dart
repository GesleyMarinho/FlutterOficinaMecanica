import 'package:flutter/material.dart';
import 'package:flutter_oficina/features/clientes/repository/cliente_repository/cliente_repository.dart';
import '../../../models/domain/cliente_model.dart';
import '../../../veiculos/screens/form_veiculo_screen.dart';
import 'detalhes_cliente_screen.dart';
import 'form_cliente_screen.dart';

class ListClientesScreen extends StatefulWidget {
  const ListClientesScreen({super.key});

  @override
  State<ListClientesScreen> createState() => _ListClintesScreenPage();
}

class _ListClintesScreenPage extends State<ListClientesScreen> {
  ClienteRepository _repository = ClienteRepository();
  List<ClienteModel> _listClientes = [];

  @override
  void initState() {
    super.initState();
    _carregarClientes();
  }

  Future<void> _carregarClientes() async {
    final lista = await _repository.listarClientes();
    setState(() {
      _listClientes = lista;
    });
  }

  void _confirmarDelete(BuildContext context, ClienteModel cliente) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deseja excluir?'),
        content: const Text('Essa ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deletarCliente(cliente.id!);
            },
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }

  Future<void> _deletarCliente(String id) async {
    await _repository.deletarClientes(id);
    await _carregarClientes();
  }

  Future<void> _detalhesCliente(ClienteModel cliente) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (contex) => DetalhesClienteScreen(cliente: cliente),
      ),
    ).then((_) => _carregarClientes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de clientes')),
      body: _listClientes.isEmpty
          ? const Center(child: Text('Nenhum cliente Cadastrado'))
          : ListView.builder(
              itemCount: _listClientes.length,
              itemBuilder: (context, index) {
                final cliente = _listClientes[index];
                return ListTile(
                  title: Text(cliente.nome),
                  subtitle: Text(cliente.telefone),
                  onTap: () => _detalhesCliente(cliente),
                  onLongPress: () => _confirmarDelete(context, cliente),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CadastroClienteScreen(cliente: cliente),
                        ),
                      ).then((_) => _carregarClientes());
                    },
                  ),
                  /*onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CadastroClienteScreen(cliente: cliente),
                      ),
                    ).then((_) => _carregarClientes());
                  },*/
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroClienteScreen()),
          ).then((_) => _carregarClientes());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
