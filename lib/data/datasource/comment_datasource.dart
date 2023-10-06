import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getComments(String productId);
  Future<void> postComment(String productId, String comment);
}

class CommentRemoteDataSource extends ICommentDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Comment>> getComments(String productId) async {
    Map<String, String> queryParameters = {
      'filter': 'product_id="$productId"',
      'expand': 'user_id',
    };

    try {
      Response<dynamic> banners = await _dio.get(
        'collections/comment/records',
        queryParameters: queryParameters,
      );

      return banners.data['items']
          .map<Comment>((jsonObject) => Comment.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
          e.response?.data['message'], e.response?.data.statusCode);
    } catch (e) {
      throw ApiException('Unknown Error', 0);
    }
  }

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      await _dio.post('collections/comment/records', data: {
        'text': comment,
        'user_id': 'lkg8xc50i07oedn',
        'product_id': productId
      });
    } on DioException catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }
}
