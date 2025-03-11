import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/cart_item.dart';
import 'package:nike_2/ui/widgets/image.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.themeData,
    required this.data,
    required this.onDeleteButtonClicked,
    required this.onIncreaseButtonClicked,
    required this.onDecreaseButtonClicked,
  });

  final ThemeData themeData;
  final CartItem data;
  final GestureTapCallback onDeleteButtonClicked;
  final GestureTapCallback onIncreaseButtonClicked;
  final GestureTapCallback onDecreaseButtonClicked;

  get product => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: themeData.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0x0d000000),
              blurRadius: 20,
            ),
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ImageLoadingService(
                    imageUrl: data.product.imageUrl,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(data.product.title),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3, left: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('تعداد'),
                    SizedBox(
                      width: 110 ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.plus_rectangle),
                            onPressed: onIncreaseButtonClicked,
                          ),
                          data.changeCountButtonLoading
                              ? SizedBox(
                                  width: 5,
                                  child: CupertinoActivityIndicator())
                              : Text(data.count.toString()),
                          IconButton(
                            icon: Icon(CupertinoIcons.minus_rectangle),
                            onPressed: onDecreaseButtonClicked,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      data.product.previousPrice.withPriceLable,
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    Text(data.product.price.withPriceLable)
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Color(0x10000000),
          ),
          TextButton(
              onPressed: onDeleteButtonClicked,
              child: data.deleteButtonLoading
                  ? Center(child: CupertinoActivityIndicator())
                  : Text('حذف از سبد خرید'))
        ],
      ),
    );
  }
}
