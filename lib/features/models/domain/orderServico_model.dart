class OrdemServicoModel {
  final String? id;
  final String veiculoId;
  final String clienteId;
  final DateTime dataEntrada;
  final DateTime? dataSaida;
  final String status;

  final String descricaoProblema;
  final double valorMaoDeObra;
  final double valorPecas;

  double get total => valorMaoDeObra + valorPecas;

  const OrdemServicoModel({
    this.id,
    required this.veiculoId,
    required this.clienteId,
    required this.dataEntrada,
    this.dataSaida,
    this.status = 'aberta',
    required this.descricaoProblema,
    required this.valorMaoDeObra,
    required this.valorPecas,
  });

  factory OrdemServicoModel.fromMap(String id, Map<String, dynamic> map) {
    return OrdemServicoModel(
      id: id,
      veiculoId: map['veiculoId'] ?? '',
      clienteId: map['clienteId'] ?? '',
      dataEntrada: DateTime.fromMillisecondsSinceEpoch(map['dataEntrada'] ?? 0),
      dataSaida: map['dataSaida'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['dataSaida']),
      status: map['status'] ?? 'aberta',
      descricaoProblema: map['descricaoProblema'] ?? '',
      valorMaoDeObra: (map['valorMaoDeObra'] ?? 0).toDouble(),
      valorPecas: (map['valorPecas'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'veiculoId': veiculoId,
      'clienteId': clienteId,
      'dataEntrada': dataEntrada.millisecondsSinceEpoch,
      'dataSaida': dataSaida?.millisecondsSinceEpoch,
      'status': status,
      'descricaoProblema': descricaoProblema,
      'valorMaoDeObra': valorMaoDeObra,
      'valorPecas': valorPecas,
    };
  }
}
