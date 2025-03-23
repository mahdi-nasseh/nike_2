import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/favorite_manager.dart';
import 'package:nike_2/data/product.dart';
import 'package:nike_2/ui/product/detail.dart';
import 'package:nike_2/ui/widgets/image.dart';

final favoriteManager = FavoriteManager();

class Product extends StatefulWidget {
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
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: 176,
      child: InkWell(
        borderRadius: widget.borderRadius,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                product: widget.product,
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
                    imageUrl: widget.product.imageUrl,
                    borderRadius: widget.borderRadius,
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
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        if (favoriteManager.isFavorite(widget.product)) {
                          favoriteManager.removeFavorite(widget.product);
                        } else {
                          favoriteManager.addFavorite(widget.product);
                        }

                        setState(() {});
                      },
                      icon: ValueListenableBuilder<Box<ProductEntity>>(
                        valueListenable: favoriteManager.listenable,
                        builder: (context, box, child) {
                          return Icon(
                            favoriteManager.isFavorite(widget.product)
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            size: 22,
                            color: favoriteManager.isFavorite(widget.product)
                                ? Colors.red
                                : Colors.black,
                          );
                        }
                      ),
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
                widget.product.title,
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
                widget.product.previousPrice.withPriceLable,
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
                widget.product.price.withPriceLable,
                style: themeData.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
