import 'dart:typed_data';
import 'package:image/image.dart' as img;

Uint8List convertToGrayscale(Uint8List imageData) {
  img.Image? image = img.decodeImage(imageData);
  if (image == null) {
    throw Exception('No se pudo decodificar la imagen');
  }

  img.Image grayscaleImage = img.grayscale(image);
  return Uint8List.fromList(img.encodeJpg(grayscaleImage));
}