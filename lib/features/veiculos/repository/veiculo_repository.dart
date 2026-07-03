import 'package:flutter_oficina/features/veiculos/data/veiculo_service.dart';
import 'package:flutter_oficina/features/models/domain/veiculo_model.dart';

class VeiculoRepository {
  final VeiculoService _veiculoService;

  VeiculoRepository({VeiculoService? veiculoService})
    : _veiculoService = veiculoService ?? VeiculoService();

  Future<void> salvarVeiculos(VeiculosModel veiculo) async {
    if (veiculo.placa.trim().isEmpty) {
      throw Exception('A placa do veículo é obrigatória');
    }
    if (veiculo.ano < 1900 || veiculo.ano > 2100) {
      throw Exception('Ano inválido');
    }
    if (veiculo.quilomentragem < 0) {
      throw Exception('Quilometragem inválida');
    }

    //chamar o service aqui depois.
    await _veiculoService.salvarVeiculoFirebase(veiculo);
  }
}
