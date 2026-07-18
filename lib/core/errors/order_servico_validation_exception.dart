class OrderServicoValidationException implements Exception {
  final String message;

  OrderServicoValidationException(this.message);

  @override
  String toString() => message;
}
