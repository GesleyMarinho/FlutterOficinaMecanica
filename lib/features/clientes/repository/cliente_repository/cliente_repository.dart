import 'package:flutter_oficina/core/errors/InvalidEmailException.dart';
import 'package:flutter_oficina/core/utils/logger.dart';
import 'package:flutter_oficina/features/clientes/data/cliente_service.dart';
import '../../../models/domain/cliente_model.dart';

class ClienteRepository {
  final ClienteService _service;

  ClienteRepository({ClienteService? service})
    : _service = service ?? ClienteService();

  final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  Future<void> salvar(ClienteModel cliente) async {
    AppLogger.debug('Repository.salvar chamado para : ${cliente.nome}');

    if (cliente.nome.trim().isEmpty) {
      throw Exception('Nome do cliente é obrigatório');
    }
    if (cliente.email != null && cliente.email!.isNotEmpty) {

      await _validacaoEmail(cliente.email!);
    }
    if (cliente.telefone.trim().length < 8) {
      throw Exception('Telefone inválido');
    }

    await _service.salvarCliente(cliente);
  }

  Future<List<ClienteModel>> listarClientes() async {
    return await _service.listarClientes();
  }

  Future<void> deletarClientes(String id) async {
    return await _service.deletarCliente(id);
  }

  Future<void> atualizarCliente(ClienteModel cliente) async {
    await _service.atualizar(cliente);
  }

  //validação do email;

  Future<void> _validacaoEmail(String email) async {
    if (!_emailRegex.hasMatch(email)) {
      throw Invalidemailexception();
    }
  }

}
