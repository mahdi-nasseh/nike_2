import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/repo/order_repository.dart';
import 'package:nike_2/ui/order/bloc/order_history_bloc.dart';
import 'package:nike_2/ui/product/detail.dart';
import 'package:nike_2/ui/widgets/image.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<OrderHistoryBloc>(
      create: (context) => OrderHistoryBloc(orderRepository: orderRepository)
        ..add(OrderHistoryStarted()),
      child: Scaffold(
        appBar: AppBar(title: Text('سوابق سفارش')),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistorySuccess) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: state.orders.length,
                padding: EdgeInsets.fromLTRB(16, 8, 16, 100),
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0x30000000)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'شناسه سفارش',
                                style: themeData.textTheme.bodyLarge,
                              ),
                              Text(order.id.toString()),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Color(0x30000000),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'مبلغ',
                                style: themeData.textTheme.bodyLarge,
                              ),
                              Text(order.payablePrice.withPriceLable),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Color(0x30000000),
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                              physics: defaultScrollPhysics,
                              itemCount: order.items.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final product = order.items[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                  child: SizedBox(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                        product: product)));
                                      },
                                      child: ImageLoadingService(
                                        imageUrl: product.imageUrl,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is OrderHistoryLoading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: themeData.colorScheme.primary,
                    size: defaultLaodingAnimationSize),
              );
            } else if (state is OrderHistoryError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else {
              throw Exception('state is not suported');
            }
          },
        ),
      ),
    );
  }
}
