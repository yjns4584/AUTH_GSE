import 'package:app_authgse/common/widgets/custom_card.dart';
import 'package:app_authgse/common/widgets/custom_outline_button.dart';
import 'package:app_authgse/features/DocumentCapture/presentation/pages/document_capture.dart';
import 'package:app_authgse/features/DocumentServiceCapture/presentation/widgets/face_display.dart';
import 'package:app_authgse/features/DocumentServiceCapture/presentation/widgets/take_photo.dart';
import 'package:app_authgse/features/faceCapture/services/api.service.dart';
import 'package:app_authgse/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:app_authgse/core/logger.dart';

final AppLogger logger = AppLogger();

class DocumentCaptureWeb extends StatefulWidget {
  const DocumentCaptureWeb({super.key});

  @override
  State<DocumentCaptureWeb> createState() => _DocumentCaptureWebState();
}

class _DocumentCaptureWebState extends State<DocumentCaptureWeb> {
  String? _base64Image;
  bool _showSendButton = false;
  bool get _canSend => _base64Image != null;
  String? _base64ImageFrontal;
  String? _base64ImageBack;

  Future<void> _goToWebService() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DocumentCapture(),
      ),
    );
    setState(() {
      _showSendButton = true;
    });
  }

  Future<void> _sendPhotos() async {
    if (!_canSend) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Debe capturar ambas fotos antes de enviar.')),
      );
      return;
    }

    final httpService = HttpService();
    final faceService = FaceService(httpService);

    try {
      await faceService.sendBase64ToServer(
        _base64ImageFrontal!,
        _base64ImageBack!,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fotos enviadas exitosamente.')),
        );
      }
    } catch (e) {
      logger.error('Error al enviar fotos: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error al enviar fotos. Inténtalo nuevamente.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Carga de documento'),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
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
                      FaceDisplay(
                        icon: _showSendButton
                            ? const Icon(
                                Icons.check,
                                size: 200,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.description,
                                size: 200,
                                color: Colors.white,
                              ),
                      ),
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
                                  text: 'Sigue con el proceso como se indica.')
                              : CustomCardWidget(
                                  text:
                                      'Carga tu cédula de ciudadanía para poder seguir con tu registro.'),
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
                                              onPressed: _goToWebService,
                                              icon: const Icon(
                                                  Icons.restart_alt_rounded,
                                                  size: 24))),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: SizedBox(
                                          height: 80,
                                          child: CustomOutlinedButton(
                                            onPressed: _sendPhotos,
                                            label: 'Seguir con registro',
                                            iconAlignment: IconAlignment.end,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : GoToWebServiceButton(
                                    onPressed: _goToWebService,
                                    label: 'Cargar documento'),
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
