import 'package:flutter_oficina/features/models/domain/orderServico_model.dart';
import '../../../core/errors/order_servico_validation_exception.dart';
import '../data/ordem_servico_service.dart';

class OrdemServicoRepository {
  final OrdemServicoService _ordemServicoService;

  OrdemServicoRepository({OrdemServicoService? ordemService})
    : _ordemServicoService = ordemService ?? OrdemServicoService();

  Future<String> salvarOrdemServico(OrdemServicoModel ordemServico) async {
    if (ordemServico.descricaoProblema.trim().isEmpty) {
      throw OrderServicoValidationException(
        'Descrição do problema é obrigatória',
      );
    }
    if (ordemServico.valorMaoDeObra < 0) {
      throw OrderServicoValidationException('Valor mão de obra inválido');
    }
    if (ordemServico.valorPecas < 0) {
      throw OrderServicoValidationException('Valor de peças inválido');
    }
    return await _ordemServicoService.salvarOrdemServicoFireBase(ordemServico);
  }

  Future<List<OrdemServicoModel>> listarPorVeiculo(String veiculoId) async {
    return await _ordemServicoService.listarPorVeiculo(veiculoId);
  }
}
