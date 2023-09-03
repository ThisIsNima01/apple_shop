import 'package:apple_shop/data/datasource/product_datasource.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getHottest();
  Future<Either<String, List<Product>>> getBestSeller();
}

class ProductRepository extends IProductRepository {
  final IProductDataSource _datasource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      final response = await _datasource.getProducts();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSeller() async {
    try {
      final response = await _datasource.getBestSeller();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Product>>> getHottest() async {
    try {
      final response = await _datasource.getHottest();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
