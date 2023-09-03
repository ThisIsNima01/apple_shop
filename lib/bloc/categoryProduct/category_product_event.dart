part of 'category_product_bloc.dart';

@immutable
abstract class CategoryProductEvent {}

class CategoryProductInitialized extends CategoryProductEvent {
  String categoryId;
  CategoryProductInitialized(this.categoryId);
}
