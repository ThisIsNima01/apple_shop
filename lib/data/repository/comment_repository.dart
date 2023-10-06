import 'package:apple_shop/data/datasource/comment_datasource.dart';
import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComments(String productId);
  Future<Either<String, String>> postComment(String productId, String comment);
}

class CommentRepository extends ICommentRepository {
  final ICommentDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      final response = await _dataSource.getComments(productId);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطایی رخ داده است');
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String productId, String comment) async {
    try {
      await _dataSource.postComment(productId, comment);
      return right('نظر شما اضافه شد');
    } on ApiException catch (e) {
      return left(e.message ?? 'خطایی رخ داده است');
    }
  }
}
