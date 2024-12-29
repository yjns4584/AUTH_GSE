import 'package:app_authgse/features/faceCapture/presentation/pages/face_capture.pages.dart';
import 'package:dio/dio.dart';

class HttpService {
  final Dio _dio;

  HttpService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
                connectTimeout: Duration(seconds: 15),
                receiveTimeout: Duration(seconds: 15)));

  Future<Response?> request({
    required String url,
    required String method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final options = Options(
        method: method,
        headers: headers ?? {'Content-Type': 'application/json'},
      );

      final response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParams,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      logger.error('Error en la solicitud HTTP: ${e.message}');
      logger.info('Detalles: ${e.response?.data}');
      return e.response;
    } catch (e) {
      logger.error('Error desconocido: $e');
      return null;
    }
  }
}
