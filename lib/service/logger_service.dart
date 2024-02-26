import 'package:logger/logger.dart';

class LoggerService{
  static Logger logger = Logger(
    printer: PrettyPrinter(),
  );
  static void d(String message){
    logger.d(message);
  }

  static void i(String message){
    logger.i(message);
  }

  static void e(String message){
    logger.e(message);
  }

  static void w(String message){
    logger.w(message);
  }
}