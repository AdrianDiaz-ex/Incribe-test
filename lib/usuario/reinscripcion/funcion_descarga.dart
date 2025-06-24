import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BoletaWebView extends StatefulWidget {
  final String url;
  const BoletaWebView({super.key, required this.url});

  @override
  State<BoletaWebView> createState() => _BoletaWebViewState();
}

class _BoletaWebViewState extends State<BoletaWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boleta PDF')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
