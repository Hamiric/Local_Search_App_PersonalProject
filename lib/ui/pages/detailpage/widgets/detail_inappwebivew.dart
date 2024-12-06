import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DetailInappwebivew extends StatefulWidget {
  const DetailInappwebivew({super.key, this.location});

  final location;

  @override
  State<DetailInappwebivew> createState() => _DetailInappwebivewState();
}

class _DetailInappwebivewState extends State<DetailInappwebivew> {
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(widget.location.link),
        ),
        initialSettings: InAppWebViewSettings(
          mediaPlaybackRequiresUserGesture: true,
          javaScriptEnabled: true,
          userAgent:
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',
        ),
        onReceivedError: (controller, request, error) {
          print('로드에러');
        },
      );
  }
}