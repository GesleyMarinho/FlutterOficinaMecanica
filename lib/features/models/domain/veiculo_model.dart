class VeiculosModel {
  final String? veiculoId;
  final String clienteId;
  final String placa;
  final String? cor;
  final String? modelo;
  final int ano;
  final double quilomentragem;

  VeiculosModel({
    this.veiculoId,
    required this.clienteId,
    required this.placa,
    required this.cor,
    this.modelo,
    required this.ano,
    required this.quilomentragem,
  });

  factory VeiculosModel.fromMap(String id, Map<String, dynamic> map) {
    return VeiculosModel(
      veiculoId: id,
      clienteId: map['clienteId'] ?? '',
      placa: map['placa'] ?? '',
      cor: map['cor'] ?? '',
      modelo: map['modelo'] ?? '',
      ano: map['ano'] ?? 0,
      quilomentragem: map['quilomentragem'] ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clienteId': clienteId,
      'placa': placa,
      'cor': cor,
      'modelo': modelo,
      'ano': ano,
      'quilomentragem': quilomentragem,
    };
  }

  @override
  String toString() =>
      'VeiculoModel(clienteId: $veiculoId, placa: $placa, cor: $cor, modelo: $modelo, ano: $ano, quilomentragem: $quilomentragem)';
}
