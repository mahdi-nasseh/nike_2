import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_2/data/repo/cart_repository.dart';
import 'package:nike_2/ui/cart/cart.dart';
import 'package:nike_2/ui/home/home.dart';
import 'package:nike_2/ui/profile/profile.dart';
import 'package:nike_2/ui/widgets/badge.dart';

const homeIndex = 0;
const cartIndex = 1;
const profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _historyTab = [];
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_historyTab.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _historyTab.last;
        _historyTab.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  void initState() {
     cartRepository.count();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'خانه'),
            BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(CupertinoIcons.cart),
                    Positioned(
                      top: -2,
                      right: -10,
                      child: ValueListenableBuilder(
                        valueListenable: CartRepository.cartItemCountNotifire,
                        builder: (context, value, child) =>
                            CustomBadge(value: value),
                      ),
                    ),
                  ],
                ),
                label: 'سبد خرید'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'پروفایل')
          ],
          currentIndex: selectedScreenIndex,
          onTap: (selectedScreen) {
            setState(() {
              _historyTab.remove(selectedScreenIndex);
              _historyTab.add(selectedScreenIndex);
              selectedScreenIndex = selectedScreen;
            });
          },
        ),
        body: IndexedStack(
          index: selectedScreenIndex,
          children: [
            navigator(homeIndex, _homeKey, const HomeScreen()),
            navigator(cartIndex, _cartKey, CartScreen()),
            navigator(
              profileIndex,
              _profileKey,
              ProfileSceen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget navigator(int index, GlobalKey key, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)),
          );
  }
}
