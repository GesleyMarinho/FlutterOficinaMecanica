import 'package:flutter_oficina/core/errors/cliente_validation_exception.dart';
import 'package:flutter_oficina/core/errors/veiculo_validation_exception.dart';
import 'package:flutter_oficina/features/models/domain/veiculo_model.dart';
import 'package:flutter_oficina/features/veiculos/data/veiculo_service.dart';

class VeiculoRepository {
  final VeiculoService _veiculoService;

  VeiculoRepository({VeiculoService? veiculoService})
    : _veiculoService = veiculoService ?? VeiculoService();

  Future<void> salvarVeiculos(VeiculosModel veiculo) async {
    if (veiculo.clienteId.trim().isEmpty) {
      throw VeiculoValidationException('ID do cliente vazio');
    }

    if (veiculo.modelo == null || veiculo.modelo!.trim().isEmpty) {
      throw VeiculoValidationException('O modelo do veiculo e obrigatorio');
    }

    if (veiculo.placa.trim().isEmpty) {
      throw VeiculoValidationException('A placa do veiculo e obrigatoria');
    }
    if (veiculo.ano < 1900 || veiculo.ano > 2100) {
      throw VeiculoValidationException('Ano invalido');
    }
    if (veiculo.quilomentragem < 0) {
      throw VeiculoValidationException('Quilometragem invalida');
    }
    //chamar o service aqui depois.
    await _veiculoService.salvarVeiculoFirebase(veiculo);
  }

  Future<List<VeiculosModel>> listarVeiculosPorCliente(String clienteId) async {
    if (clienteId.trim().isEmpty) {
      throw ClienteValidationException('Cliente sem ID');
    }
    return await _veiculoService.listarVeiculosPorCliente(clienteId);
  }
}
