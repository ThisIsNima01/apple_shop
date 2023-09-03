import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dio/dio.dart';

import '../../utils/api_exception.dart';

abstract class IProductDataSource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getHottest();
  Future<List<Product>> getBestSeller();
}

class ProductRemoteDataSource extends IProductDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await _dio.get('collections/products/records');
      return response.data['items']
          .map<Product>(
            (jsonObject) => Product.fromJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<List<Product>> getBestSeller() async {
    try {
      Map<String, String> queryParams = {'filter': 'popularity="Best Seller"'};
      var response = await _dio.get('collections/products/records',
          queryParameters: queryParams);
      return response.data['items']
          .map<Product>(
            (jsonObject) => Product.fromJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<List<Product>> getHottest() async {
    try {
      Map<String, String> queryParams = {'filter': 'popularity="Hotest"'};
      var response = await _dio.get('collections/products/records',
          queryParameters: queryParams);

      return response.data['items']
          .map<Product>(
            (jsonObject) => Product.fromJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }
}
