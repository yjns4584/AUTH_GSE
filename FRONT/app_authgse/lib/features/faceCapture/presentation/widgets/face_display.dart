import 'dart:io';
import 'package:flutter/material.dart';

class FaceDisplay extends StatelessWidget {
  final String? imagePath;
  final Icon icon;

  const FaceDisplay({super.key, required this.imagePath, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: ClipOval(
        child: imagePath == null
            ? icon
            : Image.file(
                File(imagePath!),
                width: 300,
                height: 300,
                alignment: Alignment.center,
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
      ),
    );
  }
}
