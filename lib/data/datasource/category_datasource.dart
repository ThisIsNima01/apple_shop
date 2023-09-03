import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dio/dio.dart';

import '../../utils/api_exception.dart';

abstract class ICategoryDataSource {
  Future<List<Category>> getCategories();
}

class CategoryRemoteDataSource extends ICategoryDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Category>> getCategories() async {
    try {
      Response<dynamic> banners = await Dio().get('https://nima-data.pockethost.io/api/collections/category/records');
      // Response<dynamic> banners = await _dio.get('collections/category/records');
      return banners.data['items']
          .map<Category>(
            (jsonObject) => Category.fromMapJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }
}
