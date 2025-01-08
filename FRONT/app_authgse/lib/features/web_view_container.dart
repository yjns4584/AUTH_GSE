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
          title: Text('Document Capture'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _webViewController.goBack();
                            },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _webViewController.goForward();
                            },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _webViewController.reload();
                            },
            ),
          ],
        ),
        body: InAppWebView(
          initialSettings: InAppWebViewSettings(

          ) ,
          initialUrlRequest: URLRequest(url: WebUri('https://f44hgwvn-3000.use2.devtunnels.ms/')),
        ),
      ),
    );
  }
}
