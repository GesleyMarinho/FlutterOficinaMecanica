class Invalidemailexception implements Exception{
  final String menssage = 'O endereço de email está errado';

  @override
  String toString() => menssage;
}