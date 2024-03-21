import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class whiteboard extends StatefulWidget {
  const whiteboard({super.key});

  @override
  State<whiteboard> createState() => _whiteboardState();
}

class _whiteboardState extends State<whiteboard> {
  late WebViewXController webviewController;
//late  final WebViewController cotroller;
  //..setJavaScriptMode(JavaScriptMode.disabled)
  //..loadRequest(Uri.parse('https://pub.dev/packages/webview_flutter/example'));

  void _setUrl() {
    webviewController.loadContent(
      'https://www.tldraw.com/',
      //'https://chataigpt.org/',
      SourceType.URL,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewX(
        initialContent: 'https://www.tldraw.com/',
        initialSourceType: SourceType.URL,
        onWebViewCreated: (controller) {
          webviewController = controller;
          _setUrl();
        },
      ),
    );
  }
}
