class AppLogger {
  static void info(String message, {String? tag}) {
    print('[INFO]${tag != null ? '[$tag]' : ''} $message');
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    print('[ERROR] $message');
    if (error != null) print('  └─ Erro: $error');
    if (stackTrace != null) print('  └─ Stack: $stackTrace');
  }

  static void debug(String message) {
    // Em produção, você desabilitaria esta linha com um flag
    assert(() {
      print('[DEBUG] $message');
      return true;
    }());
  }
}