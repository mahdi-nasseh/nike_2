import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_2/data/auth.dart';
import 'package:nike_2/data/repo/auth_repository.dart';
import 'package:nike_2/data/repo/cart_repository.dart';
import 'package:nike_2/ui/auth/auth_screen.dart';
import 'package:nike_2/ui/favorite/favorite_screen.dart';
import 'package:nike_2/ui/order/order_history.dart';

class ProfileSceen extends StatelessWidget {
  const ProfileSceen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('پروفایل'),
      ),
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.authChangeNotifire,
        builder: (context, authInfo, child) {
          final bool isLogin =
              authInfo != null && authInfo.accessToken.isNotEmpty;
          return Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 32, 0, 8),
                  padding: EdgeInsets.all(8),
                  width: 69,
                  height: 69,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: themeData.colorScheme.surfaceContainer),
                      shape: BoxShape.circle),
                  child: Image.asset('assets/img/nike-black.png'),
                ),
              ),
              Text(isLogin ? authInfo.email : 'کاربر میهمان'),
              SizedBox(
                height: 32,
              ),
              Divider(
                height: 1,
                color: themeData.colorScheme.surfaceContainer,
                thickness: 0.5,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        CupertinoIcons.heart,
                        weight: 0.5,
                        size: 25,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text('لیست علاقه مندی ها')
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: themeData.colorScheme.surfaceContainer,
                thickness: 0.5,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OrderHistoryScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        CupertinoIcons.cart,
                        weight: 0.5,
                        size: 25,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text('سوابق سفارش')
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: themeData.colorScheme.surfaceContainer,
                thickness: 0.5,
              ),
              InkWell(
                onTap: () {
                  if (isLogin) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: AlertDialog(
                            title: Text(
                              'خروج از حساب کاربری',
                              style: themeData.textTheme.titleLarge,
                            ),
                            content:
                                Text('آیا می‌خواهید از حساب خود خارج شوید؟'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('خیر'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  CartRepository.cartItemCountNotifire.value =
                                      0;
                                  await authRepository.signout();
                                },
                                child: Text('بله'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => AuthScreen(),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        isLogin
                            ? CupertinoIcons.arrow_right_square
                            : CupertinoIcons.arrow_left_square,
                        weight: 0.1,
                        size: 25,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(isLogin
                          ? 'خروج از حساب کاربری'
                          : 'ورود به حساب کاربری')
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: themeData.colorScheme.surfaceContainer,
                thickness: 0.5,
              ),
            ],
          );
        },
      ),
    );
  }
}
