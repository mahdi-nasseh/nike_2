import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_2/data/repo/auth_repository.dart';
import 'package:nike_2/data/repo/cart_repository.dart';
import 'package:nike_2/theme.dart';

class ProfileSceen extends StatelessWidget {
  const ProfileSceen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('پروفایل'),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: IconButton(
              onPressed: () async {
                CartRepository.cartItemCountNotifire.value = 0;
                await authRepository.signout();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: LightThemeColors.primaryTextColor,
                weight: 0.5,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 32, 0, 8),
              padding: EdgeInsets.all(8),
              width: 69,
              height: 69,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: themeData.colorScheme.surfaceContainer),
                  shape: BoxShape.circle),
              child: Image.asset('assets/img/nike-black.png'),
            ),
          ),
          Text('mahdi@gmail.com'),
          SizedBox(
            height: 32,
          ),
          Divider(
            height: 1,
            color: themeData.colorScheme.surfaceContainer,
            thickness: 0.5,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Icon(
                    CupertinoIcons.heart,
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
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Icon(
                    CupertinoIcons.cart,
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
        ],
      ),
    );
  }
}
