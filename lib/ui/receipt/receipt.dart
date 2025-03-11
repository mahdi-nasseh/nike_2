import 'package:flutter/material.dart';
import 'package:nike_2/theme.dart';

class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('رسید پرداخت'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: themeData.colorScheme.surfaceContainer),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('پرداخت با موفقیت انجام شد',
                    style: themeData.textTheme.titleLarge!.copyWith(
                        color: themeData.colorScheme.primary, fontSize: 18)),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'وضعیت سفارش',
                      style:
                          themeData.textTheme.bodySmall!.copyWith(fontSize: 16),
                    ),
                    Text(
                      'پرداخت شده',
                      style: themeData.textTheme.bodyMedium,
                    )
                  ],
                ),
                Divider(
                  color: themeData.colorScheme.surfaceContainer,
                  thickness: 0.8,
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'مبلغ',
                      style:
                          themeData.textTheme.bodySmall!.copyWith(fontSize: 16),
                    ),
                    Text(
                      '1490000 تومان',
                      style: themeData.textTheme.bodyMedium,
                    )
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
              foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
              backgroundColor:
                  WidgetStatePropertyAll<Color>(LightThemeColors.primaryColor),
            ),
            child: Text('بازگشت به صفحه اصلی'),
          )
        ],
      ),
    );
  }
}
