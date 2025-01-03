import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_authgse/common/widgets/custom_card.dart';
import 'package:app_authgse/common/widgets/custom_outline_button.dart';
import 'package:app_authgse/features/faceCapture/domain/useCases/converter_to_base64.service.dart';
import 'package:app_authgse/features/faceCapture/services/api.service.dart';
import 'package:app_authgse/services/http_service.dart';
import 'package:app_authgse/features/faceCapture/domain/useCases/camera_gallery.service.dart';
import 'package:app_authgse/core/logger.dart';

final AppLogger logger = AppLogger();

class DocumentCapture extends StatefulWidget {
  const DocumentCapture({super.key});

  @override
  State<DocumentCapture> createState() => _DocumentCaptureState();
}

class _DocumentCaptureState extends State<DocumentCapture> {
  String? _imagePathFrontal;
  String? _imagePathBack;
  String? _base64ImageFrontal;
  String? _base64ImageBack;

  bool get _canSend => _base64ImageFrontal != null && _base64ImageBack != null;

  Future<void> _captureFrontPhoto() async {
    final pathFrontal = await CameraGalleryService().takePhoto();
    if (pathFrontal != null) {
      setState(() {
        _imagePathFrontal = pathFrontal;
      });
      final base64Frontal = await convertImageToBase64(pathFrontal);
      if (base64Frontal != null) {
        setState(() {
          _base64ImageFrontal = base64Frontal;
        });
      }
    }
  }

  Future<void> _captureBackPhoto() async {
    final pathBack = await CameraGalleryService().takePhoto();
    if (pathBack != null) {
      setState(() {
        _imagePathBack = pathBack;
      });
      final base64Back = await convertImageToBase64(pathBack);
      if (base64Back != null) {
        setState(() {
          _base64ImageBack = base64Back;
        });
      }
    }
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
          _base64ImageFrontal!, _base64ImageBack!);

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
        title: const Text('Captura de Documento'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_imagePathFrontal != null)
                    Image.file(
                      File(_imagePathFrontal!),
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  else
                    const Text('Foto frontal no capturada.'),
                  const SizedBox(height: 15),
                  CustomOutlinedButton(
                    onPressed: _captureFrontPhoto,
                    label: 'Capturar Foto Frontal',
                  ),
                  const SizedBox(height: 30),
                  if (_imagePathBack != null)
                    Image.file(
                      File(_imagePathBack!),
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  else
                    const Text('Foto trasera no capturada.'),
                  const SizedBox(height: 15),
                  CustomOutlinedButton(
                    onPressed: _captureBackPhoto,
                    label: 'Capturar Foto Trasera',
                  ),
                ],
              ),
            ),
            CustomCardWidget(
              text: _canSend
                  ? 'Listo para enviar ambas fotos al servidor.'
                  : 'Por favor captura ambas fotos antes de enviar.',
            ),
            const SizedBox(height: 25),
            CustomOutlinedButton(
              onPressed: _canSend ? _sendPhotos : null,
              label: 'Enviar Fotos',
            ),
          ],
        ),
      ),
    );
  }
}
