import 'dart:io';
import 'dart:convert';

Future<String?> convertImageToBase64(String imagePath) async {
  try {
    final File imageFile = File(imagePath); 
    final List<int> imageBytes = await imageFile.readAsBytes(); 
    final String base64Image = base64Encode(imageBytes); 
    print('Imagen convertida a Base64: $base64Image'); 
    return base64Image;
  } catch (e) {
    print('Error al convertir la imagen a Base64: $e');
    return null;
  }
}
