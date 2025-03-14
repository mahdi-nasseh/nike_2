import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/repo/order_repository.dart';
import 'package:nike_2/theme.dart';
import 'package:nike_2/ui/receipt/bloc/payment_receipt_bloc.dart';

class PaymentReceiptScreen extends StatelessWidget {
  final int orderId;
  const PaymentReceiptScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('رسید پرداخت'),
      ),
      body: BlocProvider<PaymentReceiptBloc>(
        create: (context) =>
            PaymentReceiptBloc(orderRepository: orderRepository)
              ..add(PaymentReceiptStarted(orderId: orderId)),
        child: BlocBuilder<PaymentReceiptBloc, PaymentReceiptState>(
          builder: (context, state) {
            if (state is PaymentReceiptSuccess) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: themeData.colorScheme.surfaceContainer),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                            state.result.purchaseSuccess
                                ? 'پرداخت با موفقیت انجام شد'
                                : 'پرداخت ناموفق',
                            style: themeData.textTheme.titleLarge!.copyWith(
                                color: themeData.colorScheme.primary,
                                fontSize: 18)),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'وضعیت سفارش',
                              style: themeData.textTheme.bodySmall!
                                  .copyWith(fontSize: 16),
                            ),
                            Text(
                              state.result.paymentStatus,
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
                              style: themeData.textTheme.bodySmall!
                                  .copyWith(fontSize: 16),
                            ),
                            Text(
                              state.result.payableprice.withPriceLable,
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
                      foregroundColor:
                          WidgetStatePropertyAll<Color>(Colors.white),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          LightThemeColors.primaryColor),
                    ),
                    child: Text('بازگشت به صفحه اصلی'),
                  )
                ],
              );
            } else if (state is PaymentReceiptLoading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: themeData.colorScheme.primary,
                    size: defaultLaodingAnimationSize),
              );
            } else if (state is PaymentReceiptError) {
              return Center(
                child: Text('ثبت سفارش موفقیت آمیز نبود'),
              );
            } else {
              throw Exception('state is not supported');
            }
          },
        ),
      ),
    );
  }
}
