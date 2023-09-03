import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dio/dio.dart';

import '../../utils/api_exception.dart';

abstract class ICategoryProductDataSource {
  Future<List<Product>> getProductsByCategoryId(String categoryId);
}

class CategoryProductRemoteDataSource extends ICategoryProductDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProductsByCategoryId(String categoryId) async {
    try {
      Map<String, String> queryParams = {'filter': 'category="$categoryId"'};

      Response<dynamic> response;

      if (categoryId == '78q8w901e6iipuk') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: queryParams);
      }

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
