import 'dart:convert';
import 'package:app_authgse/features/userRegister/presentation/pages/user_register.pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Captura documento'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _webViewController.goBack();
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                _webViewController.goForward();
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _webViewController.reload();
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialSettings: InAppWebViewSettings(),
              initialUrlRequest: URLRequest(
                url: WebUri('https://f44hgwvn-3000.use2.devtunnels.ms/'),
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () async {
                  // Ejecutar JavaScript para hacer clic en el botón
                  await _webViewController.evaluateJavascript(source: """
                    const decodeButton = document.querySelector('.decodeButton');
                    if (decodeButton) {
                      decodeButton.click();
                    } else {
                      alert('El botón no está disponible en esta página.');
                    }
                  """);

                  // Esperar un momento para que el botón haga su trabajo
                  await Future.delayed(Duration(seconds: 5));

                  // Ejecutar JavaScript para obtener los datos parseados
                  String? parsedResult = await _webViewController.evaluateJavascript(source: """
                    JSON.stringify(window.parsedResult);
                  """);

                  if (parsedResult != null && parsedResult != 'null') {
                    // Procesar los datos parseados en Flutter
                    print('Datos parseados: $parsedResult');
                    // Puedes convertir el resultado a un mapa de datos si es necesario
                    Map<String, dynamic> resultData = jsonDecode(parsedResult);
                    // Realizar acciones con los datos obtenidos
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Datos Parseados'),
                          content: Text(
                            'AFIS Code: ${resultData['afis_code']}\n'
                            'Finger Card: ${resultData['finger_card']}\n'
                            'Document Number: ${resultData['document_number']}\n'
                            'Last Name: ${resultData['last_name']}\n'
                            'Second Last Name: ${resultData['second_last_name']}\n'
                            'First Name: ${resultData['first_name']}\n'
                            'Middle Name: ${resultData['middle_name']}\n'
                            'Gender: ${resultData['gender']}\n'
                            'Birth Date: ${resultData['birth_date']}\n'
                            'Municipality Code: ${resultData['municipality_code']}\n'
                            'Department Code: ${resultData['department_code']}\n'
                            'Blood Type: ${resultData['blood_type']}\n'
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UserRegister(
                                      parsedResult: resultData,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Seguir con registro'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    print('No se encontraron datos parseados.');
                  }
                },
                tooltip: 'Seguir con registro',
                child: const Icon(Icons.check),
              ),
            ),
          ],
        ),
      ),
    );
  }
}