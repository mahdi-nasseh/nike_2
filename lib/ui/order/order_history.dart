import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سوابق سفارش'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {return Container();}),
    );
  }
}
