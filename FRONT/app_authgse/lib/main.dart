import 'package:app_authgse/core/theme/app_theme.dart';
import 'package:app_authgse/features/faceCapture/presentation/pages/face_capture.pages.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: FaceCapture(),
    );
  }
}
