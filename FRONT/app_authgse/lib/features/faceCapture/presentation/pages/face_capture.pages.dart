import 'package:app_authgse/common/widgets/custom_card.dart';
import 'package:app_authgse/common/widgets/custom_outline_button.dart';
import 'package:app_authgse/features/faceCapture/domain/useCases/converter_to_base64.service.dart';
import 'package:app_authgse/features/faceCapture/presentation/widgets/face_display.dart';
import 'package:app_authgse/features/faceCapture/presentation/widgets/take_photo.dart';
import 'package:app_authgse/features/faceCapture/services/api.service.dart';
import 'package:app_authgse/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:app_authgse/features/faceCapture/domain/useCases/camera_gallery.service.dart';
import 'package:app_authgse/core/logger.dart';

final AppLogger logger = AppLogger();

class FaceCapture extends StatefulWidget {
  const FaceCapture({super.key});

  @override
  State<FaceCapture> createState() => _FaceCaptureState();
}

class _FaceCaptureState extends State<FaceCapture> {
  String? _imagePath;
  String? _base64Image;
  bool _showSendButton = false;

  Future<void> _capturePhoto() async {
    final path = await CameraGalleryService().takePhoto();
    if (path != null) {
      setState(() {
        _imagePath = path;
        _showSendButton = true;
      });
      final base64 = await convertImageToBase64(path);
      if (base64 != null) {
        setState(() {
          _base64Image = base64;
        });
        logger.info('Imagen en Base64: $_base64Image');
      }
    }
  }

  Future<void> _sendPhoto() async {
    final httpService = HttpService();
    final faceService = FaceService(httpService);

    await faceService.sendBase64ToServer(_base64Image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Datos faciales'),
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaceDisplay(imagePath: _imagePath),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _showSendButton
                              ? CustomCardWidget(
                                  text:
                                      'Por favor, asegúrate de que tu rostro se vea correctamente en la imagen. Si no es así, por favor, toma una nueva foto.')
                              : CustomCardWidget(
                                  text:
                                      'Por favor, tomate una foto de tu rostro para guardar tus datos biometricos de manera correcta.'),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: _showSendButton
                                ? Row(
                                    children: [
                                      Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: Colors.green,
                                                  width: 3)),
                                          child: IconButton(
                                              onPressed: _capturePhoto,
                                              icon: const Icon(Icons.camera_alt,
                                                  size: 24))),
                                      const SizedBox(
                                          width: 10), // Espaciado entre botones
                                      // Botón "Enviar"
                                      Expanded(
                                        child: SizedBox(
                                          height: 80,
                                          child: CustomOutlinedButton(
                                            onPressed: _sendPhoto,
                                            label: 'Enviar foto',
                                            iconAlignment: IconAlignment.end,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : TakePhotoButton(onPressed: _capturePhoto),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
