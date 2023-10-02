import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getComments(String productId);
}

class CommentRemoteDataSource extends ICommentDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Comment>> getComments(String productId) async {
    Map<String, String> queryParameters = {
      'product_id': productId,
    };

    try {
      Response<dynamic> banners = await _dio.get(
        'collections/comment/records',
        queryParameters: queryParameters,
      );

      return banners.data['items']
          .map<Comment>((jsonObject) => Comment.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(
          e.response?.data['message'], e.response?.data.statusCode);
    } catch (e) {
      throw ApiException('Unknown Error', 0);
    }
  }
}
