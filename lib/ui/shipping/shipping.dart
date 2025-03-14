import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_2/data/order.dart';
import 'package:nike_2/data/repo/order_repository.dart';
import 'package:nike_2/theme.dart';
import 'package:nike_2/ui/cart/cart_price_info.dart';
import 'package:nike_2/ui/payment_webview/payment_webview.dart';
import 'package:nike_2/ui/receipt/receipt.dart';
import 'package:nike_2/ui/shipping/bloc/shipping_bloc.dart';

class ShippingScreen extends StatefulWidget {
  final int totalPrice;
  final int shippingCost;
  final int payalbePrice;
  const ShippingScreen(
      {super.key,
      required this.totalPrice,
      required this.shippingCost,
      required this.payalbePrice});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: 'مهدی');

  final TextEditingController lastNameController =
      TextEditingController(text: 'ناصح');

  final TextEditingController addressController = TextEditingController(
      text: 'خیابان معلم میدان مادر بالاتر از میدان ابوذر');

  final TextEditingController postalCodeController =
      TextEditingController(text: '0123456789');

  final TextEditingController mobileController =
      TextEditingController(text: '01234567890');
  StreamSubscription? subscription;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('انتخاب تحویل گیرنده'),
        centerTitle: false,
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository: orderRepository);
          subscription = bloc.stream.listen((state) {
            if (state is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exception.message)));
            } else if (state is ShippingSuccess) {
              if (state.result.bankGatewayUrl.isNotEmpty) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                        bankGatewayUrl: state.result.bankGatewayUrl),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PaymentReceiptScreen(
                      orderId: state.result.orderId,
                    ),
                  ),
                );
              }
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(label: Text('نام')),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(label: Text('نام خانوادگی')),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: postalCodeController,
                decoration: InputDecoration(label: Text('کد پستی')),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(label: Text('شماره تماس')),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(label: Text('آدرس تحویل گیرنده')),
              ),
              SizedBox(
                height: 12,
              ),
              CartPriceInfo(
                  totalPrice: widget.totalPrice,
                  payalbePrice: widget.payalbePrice,
                  shippingCost: widget.shippingCost),
              BlocBuilder<ShippingBloc, ShippingState>(
                builder: (context, state) {
                  return state is ShippingLoading
                      ? CupertinoActivityIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              style: ButtonStyle(
                                side: WidgetStatePropertyAll(BorderSide(
                                    color: LightThemeColors.primaryColor)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                              ),
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context).add(
                                  ShippingCreateOrder(
                                    params: CreateOrderParams(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        mobile: mobileController.text,
                                        postalCode: postalCodeController.text,
                                        address: addressController.text,
                                        paymentMethodes:
                                            PaymentMethodes.cashOnDelivery),
                                  ),
                                );
                              },
                              child: Text('پرداخت در محل'),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context).add(
                                  ShippingCreateOrder(
                                    params: CreateOrderParams(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        mobile: mobileController.text,
                                        postalCode: postalCodeController.text,
                                        address: addressController.text,
                                        paymentMethodes:
                                            PaymentMethodes.online),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  foregroundColor:
                                      WidgetStatePropertyAll<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(
                                          LightThemeColors.primaryColor)),
                              child: Text('پرداخت اینترنتی'),
                            )
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
