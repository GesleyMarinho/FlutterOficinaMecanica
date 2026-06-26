// RESPONSABILIDADE: validar, orquestrar, decidir.
// A Service executa. O Repository pensa.

import 'package:flutter_oficina/core/utils/logger.dart';
import 'package:flutter_oficina/features/clientes/data/cliente_service.dart';
import 'package:flutter_oficina/features/domain/cliente_model.dart';

class ClienteRepository {
  final ClienteService _service;

  ClienteRepository({ClienteService? service})
    : _service = service ?? ClienteService();

  Future<String> salvar(ClienteModel cliente) async {
    AppLogger.debug('Repository.salvar chamado para : ${cliente.nome}');

     if (cliente.nome.trim().isEmpty) {
      throw Exception('Nome do cliente é obrigatório');
    }
    if (cliente.telefone.trim().length < 8) {
      throw Exception('Telefone inválido');
    }

    try {
      if (cliente.id == null) {
        // Novo cliente
        final id = await _service.criar(cliente);
        AppLogger.info('Cliente salvo com sucesso. ID: $id');
        return id;
      } else {
        // Atualização
        await _service.atualizar(cliente);
        return cliente.id!;
      }
    } catch (e, stack) {
      // PONTO CRÍTICO DE DEBUG: logamos erro com stack trace
      AppLogger.error('Falha ao salvar cliente', error: e, stackTrace: stack);
      rethrow; // relança para o Controller tratar na UI
    }
  }

  Future<List<ClienteModel>> listarClientes() {
    return _service.listarTodos();
  }
}
