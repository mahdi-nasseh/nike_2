import 'package:flutter/material.dart';
import 'package:nike_2/data/repo/auth_repository.dart';
import 'package:nike_2/data/repo/cart_repository.dart';

class ProfileSceen extends StatelessWidget {
  const ProfileSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  CartRepository.cartItemCountNotifire.value = 0;
                  await authRepository.signout();
                },
                child: Text('Sign Out')),
          ],
        ),
      ),
    );
  }
}
