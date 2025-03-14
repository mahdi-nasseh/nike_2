import 'package:flutter/material.dart';
import 'package:nike_2/ui/receipt/receipt.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatelessWidget {
  final String bankGatewayUrl;
  const PaymentScreen({super.key, required this.bankGatewayUrl});

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
          final uri = Uri.parse(url);
          if (uri.pathSegments.contains('checkout') &&
              uri.host == 'expertsdeveloper.ir') {
            final int orderId = int.parse(uri.queryParameters['order_id']!);
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaymentReceiptScreen(orderId: orderId),
              ),
            );
          }
        }))
        ..loadRequest(Uri.parse(bankGatewayUrl)),
    );
  }
}
