import 'package:flutter_oficina/features/clientes/repository/cliente_repository/cliente_repository.dart';
import 'package:flutter/material.dart';

import '../../models/domain/cliente_model.dart';

class CadastroClienteScreen extends StatefulWidget {
  final ClienteModel? cliente;

  const CadastroClienteScreen({super.key, this.cliente});

  @override
  State<CadastroClienteScreen> createState() => _CadastroClienteScreenState();
}

class _CadastroClienteScreenState extends State<CadastroClienteScreen> {
  final ClienteRepository _clienteRepository = ClienteRepository();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    super.dispose();
  }

  Future<void> salvarCliente() async {
    try {
      ClienteModel clienteModel = ClienteModel(
        id: widget.cliente?.id,
        nome: nomeController.text,
        email: emailController.text,
        telefone: telefoneController.text,
        dataCadastro: widget.cliente?.dataCadastro ?? DateTime.now(),
      );

      if (widget.cliente == null) {
        await _clienteRepository.salvar(clienteModel);
      } else {
        await _clienteRepository.atualizarCliente(clienteModel);
      }
      //limpa os dados da tela
      telefoneController.clear();
      emailController.clear();
      nomeController.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '.')),
          ),
        );
      }
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.cliente != null) {
      nomeController.text = widget.cliente!.nome;
      emailController.text = widget.cliente!.email ?? '';
      telefoneController.text = widget.cliente!.telefone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Cliente"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: telefoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Telefone",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await salvarCliente();
                },
                child: const Text("Salvar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
