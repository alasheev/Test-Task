import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RepoInfoScreen extends StatelessWidget {
  final String name;

  RepoInfoScreen(this.name);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://github.com/mintrocket/$name',
      ),
    );
  }
}
