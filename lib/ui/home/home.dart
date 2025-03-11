import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/repo/banner_repository.dart';
import 'package:nike_2/data/repo/product_repository.dart';
import 'package:nike_2/ui/home/bloc/home_bloc.dart';
import 'package:nike_2/ui/widgets/banner_slider.dart';
import 'package:nike_2/ui/widgets/error.dart';
import 'package:nike_2/ui/widgets/product_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocProvider<HomeBloc>(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  physics: defaultScrollPhysics,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/img/nike.png',
                            fit: BoxFit.cover,
                          ),
                        );
                      case 2:
                        return BannerSlider(banners: state.banners);
                      case 3:
                        return ProductSlider(
                          themeData: themeData,
                          products: state.latestProducts,
                          title: 'جدیدترین',
                          seeAllMethode: () {},
                        );
                      case 4:
                        return ProductSlider(
                          themeData: themeData,
                          products: state.popularProducts,
                          title: 'پربازدیدترین',
                          seeAllMethode: () {},
                        );
                      default:
                        return Container();
                    }
                  },
                );
              } else if (state is HomeError) {
                return AppExceptionWidget(
                  exception: state.exception,
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                  },
                );
              } else if (state is HomeLoading) {
                return Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: themeData.colorScheme.primary, size: 50));
              } else {
                throw Exception('state is not valid');
              }
            },
          ),
        ),
      ),
    );
  }
}
