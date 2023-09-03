import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/property.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariant>> productVariants;
  Either<String, Category> productCategory;
  Either<String, List<Property>> productProperties;
  ProductDetailResponseState(this.productImages, this.productVariants,
      this.productCategory, this.productProperties);
}
