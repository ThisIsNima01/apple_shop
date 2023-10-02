import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/data/datasource/basket_datasource.dart';
import 'package:apple_shop/data/datasource/category_datasource.dart';
import 'package:apple_shop/data/datasource/category_product_datasource.dart';
import 'package:apple_shop/data/datasource/comment_datasource.dart';
import 'package:apple_shop/data/datasource/product_datasource.dart';
import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/data/repository/category_product_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/comment_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> getItInit() async {
  // Components
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  // DataSources
  locator
      .registerFactory<IAuthenticationDataSource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICategoryDataSource>(() => CategoryRemoteDataSource());
  locator.registerFactory<IBannerDataSource>(() => BannerRemoteDataSource());
  locator.registerFactory<IProductDataSource>(() => ProductRemoteDataSource());
  locator.registerFactory<IProductDetailDataSource>(
      () => ProductDetailRemoteDataSource());
  locator.registerFactory<ICategoryProductDataSource>(
      () => CategoryProductRemoteDataSource());
  locator.registerFactory<IBasketDataSource>(() => BasketLocalDataSource());
  locator.registerFactory<ICommentDataSource>(() => CommentRemoteDataSource());

  // Repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
  locator.registerFactory<IProductDetailRepository>(
      () => ProductDetailRepository());
  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepository());
  locator.registerFactory<IBasketRepository>(() => BasketRepository());
  locator.registerFactory<ICommentRepository>(() => CommentRepository());

  // Blocs
  locator.registerSingleton<BasketBloc>(BasketBloc());
}
