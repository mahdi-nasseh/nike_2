import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_2/common/exception.dart';
import 'package:nike_2/data/banner.dart';
import 'package:nike_2/data/product.dart';

import 'package:nike_2/data/repo/banner_repository.dart';
import 'package:nike_2/data/repo/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;
  HomeBloc({required this.bannerRepository, required this.productRepository})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          final banners = await bannerRepository.getAll();
          final popular = await productRepository.getAll(ProductSort.popular);
          final latest = await productRepository.getAll(ProductSort.latest);
          emit(HomeSuccess(
              popularProducts: popular,
              latestProducts: latest,
              banners: banners));
        } catch (e) {
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
