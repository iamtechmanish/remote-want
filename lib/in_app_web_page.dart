import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:remote_want/common_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class InAppWebPage extends StatefulWidget {
  String url;

  void Function(InAppWebViewController controller) onWebViewCreated;

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
            androidOnPermissionRequest: (_, __, resources) async {
              return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT,
              );
            },

            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
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

            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true
              ),
            ),

            shouldOverrideUrlLoading: (controller, navigationAction) async {


              if (navigationAction.request.url.toString().contains("mailto:")) {
                canLaunchUrl(Uri(
                    scheme: 'mailto', path: 'hello@remotewant.com'))
                    .then((bool result) {
                  launchUrl(
                    Uri(scheme: 'mailto', path: 'hello@remotewant.com'),
                    mode: LaunchMode.externalApplication,
                  );
                });
                return NavigationActionPolicy.CANCEL;

              } else if (navigationAction.request.url.toString().contains("tg:")) { // TELEGRAM
                canLaunchUrl(
                    Uri(scheme: 'tg', path: 'resolve?domain=remotewant'))
                    .then((bool result) {
                  launchUrl(
                    Uri(scheme: 'tg', path: 'resolve?domain=remotewant'),
                    mode: LaunchMode.externalApplication,
                  );
                });
                return NavigationActionPolicy.CANCEL;

              }

              return NavigationActionPolicy.ALLOW;



              String action = navigationAction.request.url.toString().split(':').first;
              print("manish"+action);
              String url = navigationAction.request.url.toString();
              List<String> customActions = ['tel', 'whatsapp', 'mailto'];
              bool isCustomAction = customActions.contains(action);

              if (isCustomAction) {
                  _launchURL(url);
                  // and cancel the request
                  return NavigationActionPolicy.CANCEL;
                }

              if(url.contains("tg:resolve")){
                _launchURL("https://t.me/remotewant");
                // and cancel the request
                webViewController.goBack();
                return NavigationActionPolicy.ALLOW;
              }
              return NavigationActionPolicy.ALLOW;
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

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
