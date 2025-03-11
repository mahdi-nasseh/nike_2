import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/repo/auth_repository.dart';
import 'package:nike_2/data/repo/cart_repository.dart';
import 'package:nike_2/ui/auth/auth_screen.dart';
import 'package:nike_2/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_2/ui/cart/cart_item.dart';
import 'package:nike_2/ui/cart/cart_price_info.dart';
import 'package:nike_2/ui/shipping/shipping.dart';
import 'package:nike_2/ui/widgets/empty_screen.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
  final RefreshController _refreshController = RefreshController();
  StreamSubscription<CartState>? stateStreamSubsCription;
  bool stateIsSuccess = false;

  @override
  void initState() {
    AuthRepository.authChangeNotifire.addListener(authChangeNotifire);
    super.initState();
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifire.removeListener(authChangeNotifire);
    super.dispose();
  }

  void authChangeNotifire() {
    cartBloc?.add(
        CartAuthInfoChanged(authInfo: AuthRepository.authChangeNotifire.value));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<CartBloc>(
      create: (context) {
        final bloc = CartBloc(cartRepository: cartRepository);
        bloc.stream.listen((state) {
          setState(() {
            stateIsSuccess = state is CartSuccess;
          });

          if (state is CartSuccess) {
            _refreshController.refreshCompleted();
          } else if (state is CartError) {
            _refreshController.loadFailed();
          }
        });
        cartBloc = bloc;
        bloc.add(
            CartStarted(authInfo: AuthRepository.authChangeNotifire.value));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('سبد خرید'),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Visibility(
          visible: stateIsSuccess,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                onPressed: () {
                  final state = cartBloc?.state;
                  if (state is CartSuccess) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ShippingScreen(
                        payalbePrice: state.cartResponse.payablePrice,
                        totalPrice: state.cartResponse.totalPrice,
                        shippingCost: state.cartResponse.shippingCost,
                      );
                    }));
                  }
                },
                label: Text("پرداخت")),
          ),
        ),
        backgroundColor: Color.fromARGB(16, 236, 236, 236),
        body: SafeArea(
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartError) {
                return Center(
                  child: Text(state.exception.message),
                );
              } else if (state is CartLoading) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                      color: themeData.colorScheme.primary,
                      size: defaultLaodingAnimationSize),
                );
              } else if (state is CartSuccess) {
                return SmartRefresher(
                  enablePullDown: true,
                  header: ClassicHeader(
                    idleText: 'برای به‌روزرسانی به پایین بکشید',
                    failedText: 'به‌روزرسانی با شکست مواجه شد',
                    completeText: 'به‌روزرسانی با موفقیت انجام شد',
                    refreshingText: 'درحال به‌روزرسانی',
                    releaseText: 'رها کنید',
                    spacing: 3,
                    refreshingIcon: CupertinoActivityIndicator(),
                    completeIcon: Icon(
                      CupertinoIcons.check_mark_circled,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  controller: _refreshController,
                  onRefresh: () {
                    cartBloc?.add(
                      CartStarted(
                          authInfo: AuthRepository.authChangeNotifire.value,
                          isRefreshing: true),
                    );
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 64),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.cartResponse.cartItems.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.cartResponse.cartItems.length) {
                        final data = state.cartResponse.cartItems[index];
                        return CartItemWidget(
                          themeData: themeData,
                          data: data,
                          onDeleteButtonClicked: () {
                            cartBloc?.add(
                              CartDeleteButtonClicked(cartItemId: data.id),
                            );
                          },
                          onDecreaseButtonClicked: () {
                            if (data.count > 1) {
                              cartBloc?.add(CartDecreaseButtonClicked(
                                  cartItemId: data.id));
                            }
                          },
                          onIncreaseButtonClicked: () {
                            if (data.count < 5) {
                              cartBloc?.add(CartIncreaseButtonClicked(
                                  cartItemId: data.id));
                            }
                          },
                        );
                      } else {
                        return CartPriceInfo(
                          totalPrice: state.cartResponse.totalPrice,
                          payalbePrice: state.cartResponse.payablePrice,
                          shippingCost: state.cartResponse.shippingCost,
                        );
                      }
                    },
                  ),
                );
              } else if (state is CartAuthRequired) {
                return EmptyScreen(
                  message:
                      'برای مشاهده سبد خرید ابتدا وارد حساب کاربری خود شوید',
                  image: SvgPicture.asset(
                    'assets/img/auth_required.svg',
                    width: 170,
                  ),
                  callToAction: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    },
                    child: Text('ورود به حساب کاربری'),
                  ),
                );
              } else if (state is CartEmpty) {
                return EmptyScreen(
                  message: 'هیچ محصولی به سبد خرید شما اضافه نشده',
                  image: SvgPicture.asset(
                    'assets/img/empty_cart.svg',
                    width: 200,
                  ),
                );
              } else {
                throw Exception('cart state is not valid');
              }
            },
          ),
        ),
      ),
    );
  }
}
