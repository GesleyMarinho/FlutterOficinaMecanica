// O modelo é a "fonte da verdade" sobre o que é um Cliente.
// Nenhuma outra parte do código define essa estrutura.

class ClienteModel {
  final String? id;
  final String nome;
  final String telefone;
  final String? email;
  final DateTime dataCadastro;

  const ClienteModel({
    this.id,
    required this.nome,
    required this.telefone,
    this.email,
    required this.dataCadastro,
  });

  // O Firebase retorna Map<String, dynamic> — você precisa converter
  factory ClienteModel.fromMap(String id, Map<String, dynamic> map) {
    return ClienteModel(
      id: id,
      nome: map['nome'] ?? '',
      // ?? '' evita null crash
      telefone: map['telefone'] ?? '',
      email: map['email'],
      // email pode ser null, tudo bem
      dataCadastro: DateTime.fromMillisecondsSinceEpoch(
        map['dataCadastro'] ?? 0,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'dataCadastro': dataCadastro.millisecondsSinceEpoch,
      // POR QUÊ millisecondsSinceEpoch?
      // Timestamp do Firestore pode causar problemas de fuso horário.
      // int é universal e fácil de debugar.
    };
  }

  // Útil para debug — quando você fizer print(cliente) vai ver dados legíveis
  @override
  String toString() =>
      'ClienteModel(id: $id, nome: $nome, telefone: $telefone, dataCadastro: $dataCadastro)';
}
