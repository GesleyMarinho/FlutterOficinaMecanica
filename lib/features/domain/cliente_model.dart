// O modelo é a "fonte da verdade" sobre o que é um Cliente.
// Nenhuma outra parte do código define essa estrutura.

class ClienteModel {
  final String id;
  final String nome;
  final String telefone;
  final String? email;
  final DateTime dataCadastro;

  const ClienteModel({
    required this.id,
    required this.nome,
    required this.telefone,
    this.email,
    required this.dataCadastro,
  });


  factory ClienteModel.fromMap(String id, Map<String, dynamic> map) {
    return ClienteModel(
      id: id,
      nome: map['nome'] ?? '',
      telefone: map['telefone'] ?? '',
      email: map['email'],
      dataCadastro: DateTime.fromMillisecondsSinceEpoch(
        map['dataCadastro'] ?? 0,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'dataCadastro': dataCadastro.millisecondsSinceEpoch,

    };
  }

  // Útil para debug — quando você fizer print(cliente) vai ver dados legíveis
  @override
  String toString() =>
      'ClienteModel(id: $id, nome: $nome, telefone: $telefone, dataCadastro: $dataCadastro)';
}
