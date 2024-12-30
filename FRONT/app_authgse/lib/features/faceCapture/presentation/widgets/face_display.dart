import 'dart:io';
import 'package:flutter/material.dart';

class FaceDisplay extends StatelessWidget {
  final String? imagePath;

  const FaceDisplay({super.key, required this.imagePath});

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
            ? Icon(
                Icons.face,
                size: 200,
                color: Colors.white,
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
      ),
    );
  }
}
