import 'package:flutter/material.dart';
import 'package:flutter_oficina/models/cliente/Cliente.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();

  final List<Cliente> clientes = [];

  @override
  void dispose() {
    debugPrint('ClientePage destruída');

    nomeController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    cpfController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: clientes.length,
          itemBuilder: (context, index) {
            final cliente = clientes[index];
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(cliente.nomeCliente),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cliente.email),
                  Text(cliente.telefone),
                  Text(cliente.cpf),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
