import 'package:app_authgse/services/http_service.dart';
import 'package:app_authgse/core/logger.dart';

final AppLogger logger = AppLogger();

class FaceService {
  final HttpService _httpService;

  FaceService(this._httpService);

  Future<void> sendBase64ToServer(String base64ImageFront, String base64ImageBack) async {
    const String url = 'https://x6g837k2-3000.use2.devtunnels.ms/auth/pdf';

    final response = await _httpService.request(
      url: url,
      method: 'POST',
      data: {
        'imageBase64front': base64ImageFront,
        'imageBase64back': base64ImageBack,
      },
    );

    if (response != null && response.statusCode == 200) {
      logger.info('Respuesta del servidor: ${response.data}');
    } else {
      logger.error(
          'Error al enviar la información. Código: ${response?.statusCode}');
    }
  }
}
