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
import 'package:apple_shop/utils/dio_provider.dart';
import 'package:apple_shop/utils/payment_handler.dart';
import 'package:apple_shop/utils/url_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> getItInit() async {
  initComponents();

  initDataSources();

  initRepositories();

  // Blocs
  locator
      .registerSingleton<BasketBloc>(BasketBloc(locator.get(), locator.get()));
}

Future<void> initComponents() async {

  locator.registerSingleton<UrlHandler>(UrlLauncher());

  locator.registerSingleton<PaymentHandler>(ZarinpalPayment(locator.get()));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  locator.registerSingleton<Dio>(DioProvider.createDio());

}

void initDataSources() {
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
}

void initRepositories() {
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
}
