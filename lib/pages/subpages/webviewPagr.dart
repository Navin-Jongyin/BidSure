import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/main.dart';
import 'package:bidsure_2/pages/wallet_Page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String url;
  const WebView({Key? key, required this.url}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late WebViewController _controller = WebViewController();
  @override
  void initState() {
    super.initState();
    print(widget.url);

    // #docregion webview_controller
    _controller = WebViewController()..loadRequest(Uri.parse(widget.url));
    // #enddocregion webview_controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Stripe",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const WalletPage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
