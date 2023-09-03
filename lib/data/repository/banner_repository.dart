import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerCampain>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<BannerCampain>>> getBanners() async {
    try {
      var response = await _dataSource.getBanners();
      return right(response);
    } on ApiException catch (e) {
      return Left(e.message!);
    }
  }
}
