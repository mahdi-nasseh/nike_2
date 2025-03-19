import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/product.dart';
import 'package:nike_2/ui/product/detail.dart';
import 'package:nike_2/ui/widgets/image.dart';

class Product extends StatelessWidget {
  const Product({
    super.key,
    required this.product,
    required this.borderRadius,
    this.itemHeight = 189,
    this.itemWidth = 176,
  });

  final ProductEntity product;
  final BorderRadius borderRadius;
  final double itemHeight;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: 176,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                product: product,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                 aspectRatio: 0.93,
                  child: ImageLoadingService(
                    imageUrl: product.imageUrl,
                    borderRadius: borderRadius,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      CupertinoIcons.heart,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.title,
                style: themeData.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold)
                    .apply(fontSizeDelta: -0.5),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.previousPrice.withPriceLable,
                style: themeData.textTheme.bodySmall!.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: themeData.textTheme.bodySmall!.color),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.price.withPriceLable,
                style: themeData.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
