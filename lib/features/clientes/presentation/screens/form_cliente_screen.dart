import '../../../domain/cliente_model.dart';
import '../controllers/cliente_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FormClienteScreen extends StatefulWidget {
  final ClienteModel? clienteParaEditar; // null = novo cliente

  const FormClienteScreen({super.key, this.clienteParaEditar});

  @override
  State<FormClienteScreen> createState() => _FormClienteScreenState();
}

class _FormClienteScreenState extends State<FormClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Se estamos editando, preenche os campos
    if (widget.clienteParaEditar != null) {
      _nomeCtrl.text = widget.clienteParaEditar!.nome;
      _telefoneCtrl.text = widget.clienteParaEditar!.telefone;
      _emailCtrl.text = widget.clienteParaEditar!.email ?? '';
    }
  }

  @override
  void dispose() {
    // ERRO COMUM: esquecer de dar dispose nos controllers
    // Causa memory leak — o controller continua existindo mesmo sem tela
    _nomeCtrl.dispose();
    _telefoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvar(ClienteController controller) async {
    // Valida o formulário antes de qualquer coisa
    if (!_formKey.currentState!.validate()) return;

    final cliente = ClienteModel(
      id: widget.clienteParaEditar?.id,
      nome: _nomeCtrl.text.trim(),
      telefone: _telefoneCtrl.text.trim(),
      email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      dataCadastro : widget.clienteParaEditar?.dataCadastro  ?? DateTime.now(),
    );

    final sucesso = await controller.salvarCliente(cliente);

    if (sucesso && mounted) {
      // POR QUÊ checar mounted?
      // Se o usuário saiu da tela antes do await terminar,
      // tentar usar context aqui causaria crash
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente salvo!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClienteController(),
      child: Consumer<ClienteController>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.clienteParaEditar == null
                    ? 'Novo Cliente'
                    : 'Editar Cliente',
              ),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Mostra erro vindo do controller
                  if (controller.errorMessage != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.red.shade100,
                      child: Text(
                        controller.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _nomeCtrl,
                    decoration: const InputDecoration(labelText: 'Nome *'),
                    validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Informe o nome' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _telefoneCtrl,
                    decoration: const InputDecoration(labelText: 'Telefone *'),
                    keyboardType: TextInputType.phone,
                    validator: (v) =>
                    v == null || v.trim().length < 8 ? 'Telefone inválido' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _emailCtrl,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: controller.isLoading
                        ? null  // desabilita botão durante loading
                        : () => _salvar(controller),
                    child: controller.isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('Salvar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}