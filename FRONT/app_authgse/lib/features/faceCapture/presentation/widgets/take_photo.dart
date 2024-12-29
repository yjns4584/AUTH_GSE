import 'package:flutter/material.dart';

class TakePhotoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TakePhotoButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.camera_alt),
      label: const Text('Tomar foto'),
    );
  }
}
