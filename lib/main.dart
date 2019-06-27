import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.white),
      home: MyHomePage(title: '鸿雁'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController _controller;
  String _url = 'http://47.92.146.72/';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            height: MediaQuery.of(context).padding.top,
          ),
        ),
        body: WebView(
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
      onWillPop: _back,
    );
  }

  Future<bool> _back() async {
    if (_controller != null) {
      String currentUrl = await _controller.currentUrl();
      if (_url == currentUrl) {
        return new Future.value(true);
      } else {
        _controller.goBack();
      }
    }
    return new Future.value(false);
  }
}
