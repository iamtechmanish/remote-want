import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:remote_want/common_functions.dart';

class InAppWebPage extends StatefulWidget {
  String url ;
  void Function(InAppWebViewController controller) onWebViewCreated ;

  InAppWebPage({required this.url, required this.onWebViewCreated});

  @override
  State<InAppWebPage> createState() => _InAppWebPageState();
}

class _InAppWebPageState extends State<InAppWebPage> {
  double _progress = 0;
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest:
                URLRequest(url: Uri.parse(widget.url)),
            onWebViewCreated: (InAppWebViewController controller) {
              webViewController = controller;
              widget.onWebViewCreated(controller);
            },
            onLoadStart: (controller, url) {},
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              setState(() {
                _progress = progress / 100;
              });
            },
          ),
          _progress < 1
              ? SizedBox(
                  height: 4,
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.orange.withOpacity(0.2),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
