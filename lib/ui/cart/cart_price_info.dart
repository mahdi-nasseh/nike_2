import 'package:flutter/material.dart';
import 'package:nike_2/common/utils.dart';

class CartPriceInfo extends StatelessWidget {
  final int totalPrice;
  final int payalbePrice;
  final int shippingCost;
  const CartPriceInfo(
      {super.key,
      required this.totalPrice,
      required this.payalbePrice,
      required this.shippingCost});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 6),
          child: Text(
            'جزئیات خرید',
            style: themeData.textTheme.bodySmall!.copyWith(fontSize: 18),
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(12, 0, 12, 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: themeData.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  color: Color(0x0b000000),
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('مبلغ کل خرید'),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                        
                            text: totalPrice.separateByComma,
                            style: DefaultTextStyle.of(context)
                                .style
                                .copyWith(fontSize: 14),
                            children: [
                              TextSpan(
                                text: ' تومان',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color(0x10000000),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('هزینه ارسال'),
                      Text(shippingCost.withPriceLable)
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color(0x0e000000),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('مبلغ قابل پرداخت'),
                      RichText(
                        text: TextSpan(
                            text: payalbePrice.separateByComma,
                            style: DefaultTextStyle.of(context).style.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' تومان',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10)),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
