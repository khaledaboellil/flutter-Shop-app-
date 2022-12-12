import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class  WebView_Screen extends StatelessWidget {


  final url ;
  WebView_Screen(this.url) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  WebView(initialUrl: url)
    );
  }
}
