import 'package:app_authgse/features/faceCapture/domain/useCases/converter_to_base64.service.dart';
import 'package:flutter/material.dart';
import 'package:app_authgse/features/faceCapture/domain/useCases/camera_gallery.service.dart';
import 'dart:io';

class FaceCapture extends StatefulWidget {
  const FaceCapture({super.key});

  @override
  State<FaceCapture> createState() => _FaceCaptureState();
}

class _FaceCaptureState extends State<FaceCapture> {
  String? _imagePath;
  String? _base64Image;

  Future<void> _capturePhoto() async {
    final path = await CameraGalleryService().takePhoto();
    if (path != null) {
      setState(() {
        _imagePath = path;
      });
      final base64 = await convertImageToBase64(path);
      if (base64 != null) {
        setState(() {
          _base64Image = base64;
        });
        print('Imagen en Base64: $_base64Image');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos faciales'),
        centerTitle: true,
        elevation: 25,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imagePath == null
                  ? const Icon(
                      Icons.person,
                      size: 150,
                      color: Colors.grey,
                    )
                  : Image.file(
                      File(_imagePath!),
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _capturePhoto,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Tomar foto'),
              ),
              const SizedBox(height: 20),
              _base64Image != null
                  ? Text(
                      'Imagen convertida a Base64 (truncada):\n${_base64Image!.substring(0, 100)}...',
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
