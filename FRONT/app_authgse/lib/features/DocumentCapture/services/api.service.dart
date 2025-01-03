import 'package:app_authgse/features/faceCapture/presentation/pages/face_capture.pages.dart';
import 'package:app_authgse/services/http_service.dart';

class FaceService {
  final HttpService _httpService;

  FaceService(this._httpService);

  Future<void> sendBase64ToServer(String base64Image) async {
    const String url = 'https://f44hgwvn-5000.use2.devtunnels.ms/compare';

    final response = await _httpService.request(
      url: url,
      method: 'POST',
      data: {'image': base64Image},
    );

    if (response != null && response.statusCode == 200) {
      logger.info('Respuesta del servidor: ${response.data}');
    } else {
      logger.error('Error al enviar la información. Código: ${response?.statusCode}');
    }
  }
}
