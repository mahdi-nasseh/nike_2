import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/favorite_manager.dart';
import 'package:nike_2/data/product.dart';
import 'package:nike_2/theme.dart';
import 'package:nike_2/ui/product/detail.dart';
import 'package:nike_2/ui/widgets/image.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('لیست علاقه مندی‌ها'),
      ),
      body: ValueListenableBuilder<Box<ProductEntity>>(
          valueListenable: favoriteManager.listenable,
          builder: (context, box, child) {
            final List<ProductEntity> products = box.values.toList();
            return ListView.builder(
              physics: defaultScrollPhysics,
              padding: EdgeInsets.only(top: 8, bottom: 100),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final ProductEntity product = products[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(product: product)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Color(0x0a000000), blurRadius: 20),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 86,
                            height: 86,
                            child: ImageLoadingService(
                              imageUrl: product.imageUrl,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: themeData.textTheme.bodyLarge,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                product.previousPrice.withPriceLable,
                                style: themeData.textTheme.bodySmall!.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor:
                                        LightThemeColors.secondaryTextColor),
                              ),
                              Text(product.price.withPriceLable),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
