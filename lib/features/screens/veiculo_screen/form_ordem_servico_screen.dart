import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de ordem de servico"),
        centerTitle: true,
      ),
    );
  }
}
