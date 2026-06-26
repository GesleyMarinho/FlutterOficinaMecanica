import 'package:flutter_oficina/core/utils/logger.dart';
import 'package:flutter_oficina/features/clientes/repository/cliente_repository.dart';
import 'package:flutter_oficina/features/domain/cliente_model.dart';
import 'package:flutter/material.dart';

class ClienteController extends ChangeNotifier {
  final ClienteRepository _repository;

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;

  ClienteController({ClienteRepository? repository})
    : _repository = repository ?? ClienteRepository();

  Stream<List<ClienteModel>> get clientes => _repository.listarClientes();

  Future<bool> salvarCliente(ClienteModel cliente) async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    AppLogger.debug('Controller: iniciando o salvamento');

    try {
      await _repository.salvar(cliente);
      successMessage = 'Cliente salvo com sucesso!';
      AppLogger.info('Controller: Cliente salvo com sucesso !');
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      AppLogger.error('Controller: erro ao salvar', error: e);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
