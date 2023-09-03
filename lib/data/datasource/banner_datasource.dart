import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IBannerDataSource {
  Future<List<BannerCampain>> getBanners();
}

class BannerRemoteDataSource extends IBannerDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerCampain>> getBanners() async {
    try {
      Response<dynamic> banners = await Dio().get('https://nima-data.pockethost.io/api/collections/banner/records');
      // Response<dynamic> banners = await _dio.get('collections/banner/records');

      return banners.data['items']
          .map<BannerCampain>(
              (jsonObject) => BannerCampain.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(
          e.response?.data['message'], e.response?.data.statusCode);
    } catch (e) {
      throw ApiException('Unknown Error', 0);
    }
  }
}
