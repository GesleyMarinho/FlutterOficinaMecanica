class VeiculoValidationException implements Exception{
  final String message;

  VeiculoValidationException(this.message);

  @override
  String toString() => message;

}