import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/property.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dartz/dartz.dart';

import '../../utils/api_exception.dart';
import '../model/product_image.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getProductImage(String productId);

  Future<Either<String, List<VariantType>>> getVariantTypes();

  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId);

  Future<Either<String, Category>> getProductCategory(String categoryId);

  Future<Either<String, List<Property>>> getProductProperties(String productId);
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<ProductImage>>> getProductImage(
      String productId) async {
    try {
      final response = await _dataSource.getGallery(productId);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantTypes() async {
    try {
      final response = await _dataSource.getVariantTypes();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId) async {
    try {
      final response = await _dataSource.getProductVariants(productId);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async {
    try {
      final response = await _dataSource.getProductCategory(categoryId);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Property>>> getProductProperties(
      String productId) async {
    try {
      final response = await _dataSource.getProductProperties(productId);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
