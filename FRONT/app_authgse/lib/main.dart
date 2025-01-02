import 'package:app_authgse/core/theme/app_theme.dart';
import 'package:app_authgse/features/captureCedula/presentation/pages/capture_user_cedula.dart';
import 'package:app_authgse/features/faceCapture/presentation/pages/face_capture.pages.dart';
import 'package:app_authgse/features/initPage/presentation/pages/init_page.dart';
import 'package:app_authgse/features/userLogin/presentation/pages/user_login.dart';
import 'package:app_authgse/features/userRegister/presentation/pages/user_register.pages.dart';
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
      home: InitPage(),
    );
  }
}
