class ClienteValidationException implements Exception {
  final String message;

  ClienteValidationException(this.message);

  @override
  String toString() => message;
}
