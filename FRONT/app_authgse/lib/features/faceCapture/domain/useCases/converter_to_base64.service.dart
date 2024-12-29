import 'dart:io';
import 'dart:convert';

import 'package:app_authgse/features/faceCapture/presentation/pages/face_capture.pages.dart' as face_capture_pages;

Future<String?> convertImageToBase64(String imagePath) async {
  try {
    final File imageFile = File(imagePath);
    final List<int> imageBytes = await imageFile.readAsBytes();
    face_capture_pages.logger.info('Convirtiendo imagen a Base64');
    face_capture_pages.logger.info('Tamaño de la imagen (bytes): ${imageBytes.length} bytes');
    final String base64Image = base64Encode(imageBytes);
    face_capture_pages.logger.info('Tamaño de la imagen (Base64): ${base64Image.length} bytes');
    face_capture_pages.logger.info('Imagen convertida a Base64');
    return base64Image;
  } catch (e) {
    face_capture_pages.logger.error('Error al convertir la imagen a Base64: $e');
    return null;
  }
}
