import 'package:flutter/material.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/product.dart';
import 'package:nike_2/ui/product/product.dart';

class ProductSlider extends StatelessWidget {
  final List<ProductEntity> products;
  final String title;
  final GestureTapCallback seeAllMethode;
  const ProductSlider({
    super.key,
    required this.themeData,
    required this.products,
    required this.title,
    required this.seeAllMethode,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: themeData.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: seeAllMethode,
                child: Text('مشاهده همه'),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: SizedBox(
            height: 290,
            child: ListView.builder(
                itemCount: products.length,
                physics: defaultScrollPhysics,
                padding: EdgeInsets.all(4),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Product(
                      product: product,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
