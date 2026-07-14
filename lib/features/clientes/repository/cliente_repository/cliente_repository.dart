import 'package:flutter_oficina/core/errors/cliente_validation_exception.dart';
import 'package:flutter_oficina/core/utils/logger.dart';
import 'package:flutter_oficina/features/clientes/data/cliente_service.dart';
import '../../../models/domain/cliente_model.dart';

class ClienteRepository {
  final ClienteService _service;

  ClienteRepository({ClienteService? service})
    : _service = service ?? ClienteService();

  final RegExp _emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  Future<void> salvar(ClienteModel cliente) async {
    AppLogger.debug('Repository.salvar chamado para : ${cliente.nome}');

    _validarCliente(cliente);

    await _service.salvarCliente(cliente);
  }

  Future<List<ClienteModel>> listarClientes() async {
    return await _service.listarClientes();
  }

  Future<void> deletarClientes(ClienteModel cliente) async {
    final id = cliente.id;

    if (id == null || id.isEmpty) {
      throw ClienteValidationException('Cliente sem ID para exclusao');
    }

    return await _service.deletarCliente(id);
  }

  Future<void> atualizarCliente(ClienteModel cliente) async {
    _validarCliente(cliente);
    await _service.atualizar(cliente);
  }

  void _validarCliente(ClienteModel cliente) {
    _validarNome(cliente.nome);
    _validarEmailSeInformado(cliente.email);
    _validarTelefone(cliente.telefone);
  }

  void _validarNome(String nome) {
    if (nome.trim().isEmpty) {
      throw ClienteValidationException('Nome do cliente e obrigatorio');
    }
  }

  void _validarEmailSeInformado(String? email) {
    if (email == null || email.trim().isEmpty) {
      return;
    }

    _validarEmail(email);
  }

  void _validarTelefone(String telefone) {
    if (telefone.trim().length < 8) {
      throw ClienteValidationException('Telefone invalido');
    }
  }

  void _validarEmail(String email) {
    if (!_emailRegex.hasMatch(email.trim())) {
      throw ClienteValidationException('O endereco de email esta invalido');
    }
  }
}
