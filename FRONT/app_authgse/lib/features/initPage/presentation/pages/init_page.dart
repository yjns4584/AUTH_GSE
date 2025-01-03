import 'package:app_authgse/common/widgets/custom_outline_button.dart';
import 'package:app_authgse/common/widgets/custom_page_template.dart';
import 'package:app_authgse/features/DocumentServiceCapture/presentation/pages/document_service_capture.dart';
import 'package:app_authgse/features/userLogin/presentation/pages/user_login.dart';
import 'package:app_authgse/features/userRegister/presentation/pages/user_register.pages.dart';
import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPageTemplate(
      title: const Center(
        child: Text(
          'Bienvenido',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Por favor selecciona una opción para continuar:',
            style: TextStyle(fontSize: 18, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: 80,
              child: CustomOutlinedButton(
                borderColor: Colors.green.shade900,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserLogin(),
                    ),
                  );
                },
                label: 'Iniciar Sesión',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: SizedBox(
            width: double.infinity,
            height: 80,
            child: CustomOutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DocumentCaptureWeb(),
                  ),
                );
              },
              label: 'Registrarme',
            ),
          ))
        ],
      ),
    );
  }
}
