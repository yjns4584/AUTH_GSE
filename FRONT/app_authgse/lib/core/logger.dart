import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  late final Logger _logger;

  AppLogger._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2, 
        errorMethodCount: 8, 
        lineLength: 80,
        colors: true, 
        printEmojis: true, 
        dateTimeFormat: DateTimeFormat.onlyDate, 
      ),
    );
  }

  factory AppLogger() {
    return _instance;
  }

  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  void info(String message) {
    _logger.i(message);
  }

  void warning(String message) {
    _logger.w(message);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void verbose(String message) {
    _logger.t(message);
  }

  void wtf(String message) {
    _logger.f(message);
  }
}
