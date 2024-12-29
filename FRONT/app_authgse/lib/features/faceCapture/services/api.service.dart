import 'package:app_authgse/features/faceCapture/presentation/pages/face_capture.pages.dart';
import 'package:dio/dio.dart';

Future<void> sendBase64ToServer(base64Image) async {
  final dio = Dio();
  final String url = 'https://xzfrbz1n-3000.use2.devtunnels.ms/api/face'; 

  try {
    final response = await dio.post(
      url,
      data: {
        'imageBase64': base64Image, 
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json', 
        },
      ),
    );
    logger.warning('Respuesta del servidor: ${response.data}');
  } catch (e) {
    print('Error al enviar la información: $e');
  }
}
