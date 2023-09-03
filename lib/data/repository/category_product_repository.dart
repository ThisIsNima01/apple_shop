import 'package:apple_shop/data/datasource/category_product_datasource.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dartz/dartz.dart';

import '../../utils/api_exception.dart';
import '../model/product.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductsByCategoryId(
      String categoryId);
}

class CategoryProductRepository extends ICategoryProductRepository {
  final ICategoryProductDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Product>>> getProductsByCategoryId(
      String categoryId) async {
    try {
      final response = await _dataSource.getProductsByCategoryId(categoryId);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
