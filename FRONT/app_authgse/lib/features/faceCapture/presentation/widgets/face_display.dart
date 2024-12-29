import 'dart:io';
import 'package:flutter/material.dart';

class FaceDisplay extends StatelessWidget {
  final String? imagePath;

  const FaceDisplay({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: imagePath == null
          ? const Icon(
              Icons.face,
              size: 200,
              color: Colors.black,
            )
          : Image.file(
              File(imagePath!),
              width: 300,
              height: 300,
              alignment: Alignment.center,
              repeat: ImageRepeat.noRepeat,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
    );
  }
}

