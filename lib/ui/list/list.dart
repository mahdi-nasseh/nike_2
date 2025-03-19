import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nike_2/common/exception.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/repo/product_repository.dart';
import 'package:nike_2/theme.dart';
import 'package:nike_2/ui/list/bloc/product_list_bloc.dart';
import 'package:nike_2/ui/product/product.dart';
import 'package:nike_2/ui/widgets/error.dart';

class ProductListScreen extends StatefulWidget {
  final int sort;
  const ProductListScreen({super.key, required this.sort});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

enum ViewType {
  list,
  grid,
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? bloc;
  ViewType viewType = ViewType.grid;

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<ProductListBloc>(
      create: (context) {
        bloc = ProductListBloc(productRepository: productRepository)
          ..add(ProductListStarted(sort: widget.sort));
        return bloc!;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('کفش ورزشی'),
        ),
        body: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              final products = state.products;
              return Column(
                children: [
                  Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // border: Border(
                      //   top: BorderSide(
                      //       color: themeData.colorScheme.surfaceContainer,
                      //       width: 1),
                      // ),
                      color: themeData.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x30000000),
                          blurRadius: 25,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 16),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 16, 16, 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'مرتب سازی',
                                                style: themeData
                                                    .textTheme.titleMedium,
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount:
                                                      state.sortName.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final int selectedSort =
                                                        state.sort;
                                                    return InkWell(
                                                      onTap: () {
                                                        bloc?.add(
                                                            ProductListStarted(
                                                                sort: index));

                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 14),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              state.sortName[
                                                                  index],
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            if (selectedSort ==
                                                                index)
                                                              Icon(
                                                                CupertinoIcons
                                                                    .check_mark_circled_solid,
                                                                color: themeData
                                                                    .colorScheme
                                                                    .primary,
                                                                size: 20,
                                                              )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.sort_down,
                                    size: 25,
                                    color: LightThemeColors.primaryTextColor,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'مرتب سازی',
                                        style: themeData.textTheme.bodyMedium,
                                      ),
                                      Text(
                                        state.sortName[state.sort],
                                        style: themeData.textTheme.bodySmall,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                viewType == ViewType.grid
                                    ? viewType = ViewType.list
                                    : viewType = ViewType.grid; 
                              });
                            },
                            icon: Icon(
                              CupertinoIcons.square_grid_2x2,
                              size: 25,
                              color: LightThemeColors.primaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.60,
                          crossAxisCount: viewType == ViewType.grid ? 2 : 1,
                          crossAxisSpacing: 8),
                      itemCount: products.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Product(
                            product: product, borderRadius: BorderRadius.zero);
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ProductlistError) {
              return AppExceptionWidget(
                exception: AppException(),
                onPressed: () {
                  BlocProvider.of<ProductListBloc>(context).add(
                    ProductListStarted(sort: widget.sort),
                  );
                },
              );
            } else if (state is ProductListLoading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: themeData.colorScheme.primary,
                    size: defaultLaodingAnimationSize),
              );
            } else {
              throw Exception('state is not validate');
            }
          },
        ),
      ),
    );
  }
}
