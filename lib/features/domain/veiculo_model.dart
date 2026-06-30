class VeiculosModel {
  final String? id;
  final String clienteId;
  final String placa;
  final String cor;
  final String? modelo;
  final int ano;
  final double quilomentragem;

  VeiculosModel({
    this.id,
    required this.clienteId,
    required this.placa,
    required this.cor,
    this.modelo,
    required this.ano,
    required this.quilomentragem
  });

  factory VeiculosModel.fromMap
      (String id, Map<String, dynamic> map){
    return VeiculosModel(
        id: id,
        clienteId
            : map['clienteId'] ?? '',
        placa: map['placa'] ?? '',
        cor: map['cor'] ?? '',
        modelo: map['modelo'] ?? '',
        ano: map['ano'] ?? '',
        quilomentragem: map['quilomentragem'] ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clienteId': clienteId,
      'placa': placa,
      'cor': cor,
      'ano': ano,
      'quilomentragem': quilomentragem
    };
  }


}
