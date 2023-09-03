import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/property.dart';
import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dio/dio.dart';

import '../../utils/api_exception.dart';
import '../model/category.dart';

abstract class IProductDetailDataSource {
  Future<List<ProductImage>> getGallery(String productId);

  Future<List<VariantType>> getVariantTypes();

  Future<List<Variant>> getVariants(String productId);

  Future<List<ProductVariant>> getProductVariants(String productId);

  Future<Category> getProductCategory(String categoryId);

  Future<List<Property>> getProductProperties(String productId);
}

class ProductDetailRemoteDataSource extends IProductDetailDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    try {
      final Map<String, String> qParams = {
        'filter': 'product_id="${productId}"'
      };
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParams);
      return response.data['items']
          .map<ProductImage>(
            (jsonObject) => ProductImage.fromJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VariantType>(
            (jsonObject) => VariantType.fromJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<List<Variant>> getVariants(String productId) async {
    try {
      final Map<String, String> qParams = {'filter': 'product_id="$productId"'};

      var response = await _dio.get('collections/variants/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Variant>(
            (jsonObject) => Variant.fromJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariants(String productId) async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants(productId);

    List<ProductVariant> productVariantList = [];

    try {
      for (var variantType in variantTypeList) {
        var finalVariantList = variantList
            .where((variant) => variant.typeId == variantType.id)
            .toList();

        productVariantList.add(ProductVariant(variantType, finalVariantList));
      }

      return productVariantList;
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<Category> getProductCategory(String categoryId) async {
    try {
      Map<String, String> queryParams = {'filter': 'id="$categoryId"'};
      var response = await _dio.get('collections/category/records',
          queryParameters: queryParams);

      return Category.fromMapJson(response.data['items'][0]);
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<List<Property>> getProductProperties(String productId) async {
    try {
      final Map<String, String> qParams = {'filter': 'product_id="$productId"'};

      var response = await _dio.get('collections/properties/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Property>(
            (jsonObject) => Property.fromJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }
}
