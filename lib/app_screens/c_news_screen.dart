import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

final String selectedUrl = "https://mediaexcellencetv.com/";

//full scaffold
class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {

  final flutterWebViewPlugin = FlutterWebviewPlugin();


  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: selectedUrl,
      appBar: MexAppBar.create("CNews"),
      withZoom: false,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),

    );
  }
}


