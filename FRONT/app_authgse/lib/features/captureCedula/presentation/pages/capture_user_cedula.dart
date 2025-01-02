import 'package:app_authgse/features/captureCedula/presentation/widgets/scan_result.dart';
import 'package:app_authgse/features/captureCedula/presentation/widgets/unsuported_platform_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

class CaptureUserCedula extends StatefulWidget {
  const CaptureUserCedula({super.key});

  @override
  State<CaptureUserCedula> createState() => _CaptureUserCedulaState();
}

class _CaptureUserCedulaState extends State<CaptureUserCedula> {
  Code? result;
  @override
  Widget build(BuildContext context) {  
   if (kIsWeb || !_isCameraSupported()) {  
     return const UnsupportedPlatformWidget();  
   }

   return Scaffold(  
     appBar: AppBar(title: const Text('Scan Code')),  
     body: result != null && result?.isValid == true  
         ? ScanResultWidget(  
       result: result,  
       onScanAgain: () => setState(() => result = null),  
     )  
         : _buildScanner(),  
   );  
 }

 bool _isCameraSupported() {  
   return defaultTargetPlatform == TargetPlatform.iOS ||  
       defaultTargetPlatform == TargetPlatform.android;  
 }

 Widget _buildScanner() {  
   return ReaderWidget(  
     onScan: _onScanSuccess,  
     onScanFailure: _onScanFailure,  
     onControllerCreated: _onControllerCreated,  
     resolution: ResolutionPreset.high,  
     lensDirection: CameraLensDirection.back,  
     codeFormat: Format.any,  
     showGallery: false,  
     cropPercent: 0.7,  
     toggleCameraIcon: const Icon(Icons.switch_camera),  
     actionButtonsBackgroundBorderRadius: BorderRadius.circular(10),  
   );  
 }

 void _onControllerCreated(_, Exception? error) {  
   if (error != null) {  
     _showMessage(context, 'Error: $error');  
   }  
 }

 void _onScanSuccess(Code? code) {  
   setState(() {  
     result = code;  
   });  
 }

 void _onScanFailure(Code? code) {  
   setState(() {  
     result = code;  
   });  
   if (code?.error?.isNotEmpty == true) {  
     _showMessage(context, 'Error: ${code?.error}');  
   }  
 }

 void _showMessage(BuildContext context, String message) {  
   ScaffoldMessenger.of(context).hideCurrentSnackBar();  
   ScaffoldMessenger.of(context).showSnackBar(  
     SnackBar(content: Text(message)),  
   );  
 }  
}