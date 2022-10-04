import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WebView(initialUrl: 'https://pub.dev/packages/connectycube_flutter_call_kit');
  }
}