import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/favorite_manager.dart';
import 'package:nike_2/data/product.dart';
import 'package:nike_2/data/repo/auth_repository.dart';
import 'package:nike_2/data/repo/cart_repository.dart';
import 'package:nike_2/theme.dart';
import 'package:nike_2/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_2/ui/product/bloc/product_bloc.dart';
import 'package:nike_2/ui/widgets/image.dart';

final FavoriteManager favoriteManager = FavoriteManager();

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.product});
  final ProductEntity product;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  StreamSubscription<ProductState>? stateSubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessangerKey = GlobalKey();
  @override
  void dispose() {
    stateSubscription?.cancel();
    _scaffoldMessangerKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final bloc = ProductBloc(cartRepository: cartRepository);
              //for remove the listen after dispose this page =>
              stateSubscription = bloc.stream.listen((state) {
                if (state is ProductAddToCartButtonSuccess) {
                  _scaffoldMessangerKey.currentState?.showSnackBar(SnackBar(
                    content: Text('کالا با موفقیت به سبد خرید شما اضافه شد'),
                  ));
                } else if (state is ProductAddToCartButtonError) {
                  _scaffoldMessangerKey.currentState?.showSnackBar(
                    SnackBar(
                      content: Text(state.exception.message),
                    ),
                  );
                }
              });
              return bloc;
            },
          ),
          BlocProvider(
              create: (context) => CartBloc(cartRepository: cartRepository))
        ],
        child: ScaffoldMessenger(
          key: _scaffoldMessangerKey,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width - 48,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onPressed: () {
                        BlocProvider.of<ProductBloc>(context).add(
                            ProductAddToCartButtonClicked(
                                productId: widget.product.id));
                        BlocProvider.of<CartBloc>(context).add(CartStarted(
                            authInfo: AuthRepository.authChangeNotifire.value));
                      },
                      label: state is ProductAddToCartButtonLoading
                          ? CupertinoActivityIndicator(
                              color: themeData.colorScheme.onSecondary,
                            )
                          : Text(
                              'افزودن به سبد خرید',
                              style: themeData.textTheme.labelLarge!.copyWith(
                                  color: themeData.colorScheme.onSecondary,
                                  fontWeight: FontWeight.bold),
                            ));
                },
              ),
            ),
            body: SafeArea(
              child: CustomScrollView(
                physics: defaultScrollPhysics,
                slivers: [
                  SliverAppBar(
                    actions: [
                      IconButton(
                          onPressed: () {
                            if (favoriteManager.isFavorite(widget.product)) {
                              favoriteManager.removeFavorite(widget.product);
                            } else {
                              favoriteManager.addFavorite(widget.product);
                            }
                            setState(() {});
                          },
                          icon: favoriteManager.isFavorite(widget.product)
                              ? Icon(
                                  CupertinoIcons.heart_fill,
                                  size: 22,
                                  color: Colors.red,
                                )
                              : Icon(CupertinoIcons.heart)),
                    ],
                    flexibleSpace:
                        ImageLoadingService(imageUrl: widget.product.imageUrl),
                    expandedHeight: MediaQuery.of(context).size.width * 0.6,
                    foregroundColor: LightThemeColors.primaryTextColor,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.title,
                                style: themeData.textTheme.titleLarge,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.product.previousPrice.withPriceLable,
                                    style: themeData.textTheme.bodySmall!
                                        .copyWith(
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: themeData
                                                .textTheme.bodySmall!.color),
                                  ),
                                  Text(
                                    widget.product.price.withPriceLable,
                                    style: themeData.textTheme.bodyMedium!
                                        .copyWith(fontSize: 16),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                              'این کفش بسیار راحت و نرم می‌باشد و مناسب پیاده‌روی و استفاده روزمره می‌باشد. هیچ فشار مضاعفی از این کفش به کمر و زانو منتقل نمی‌شود.'),
                          const SizedBox(
                            height: 24,
                          ),
                          //comment container
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'نظرات کابران',
                                style: themeData.textTheme.bodySmall!
                                    .copyWith(fontSize: 16),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('ثبت نظر'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //CommentList(productId: product.id),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('کامنتی موجود نیست'),
                        const SizedBox(
                          height: 250,
                          width: 500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
