import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/app_colours.dart';

class WebPage extends StatefulWidget {
  final String webUrl;
  const WebPage({Key? key, required this.webUrl}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColour.kappBarColour,
        elevation: 0,
        toolbarHeight: 60.h,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: WebView(
        initialUrl: widget.webUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
