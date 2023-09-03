import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSearchLoading extends HomeState {}

class HomeSearchRequestSuccessState extends HomeState {
  List<Product> productList;
  HomeSearchRequestSuccessState(this.productList);
}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<BannerCampain>> bannerList;
  Either<String, List<Category>> categoryList;
  List<Product> productList;
  Either<String, List<Product>> bestSellerProductList;
  Either<String, List<Product>> hottestProductList;

  HomeRequestSuccessState(this.bannerList, this.categoryList, this.productList,
      this.hottestProductList, this.bestSellerProductList);
}

