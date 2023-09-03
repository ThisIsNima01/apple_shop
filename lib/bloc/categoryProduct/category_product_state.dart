part of 'category_product_bloc.dart';

@immutable
abstract class CategoryProductState {}

class CategoryProductInitial extends CategoryProductState {}

class CategoryProductLoading extends CategoryProductState {
  
}

class CategoryProductSuccess extends CategoryProductState {
  Either<String, List<Product>> productListByCategory;
  CategoryProductSuccess(this.productListByCategory);
}
