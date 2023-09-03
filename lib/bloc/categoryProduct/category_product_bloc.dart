import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../data/repository/category_product_repository.dart';

part 'category_product_event.dart';
part 'category_product_state.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ICategoryProductRepository categoryProductRepository = locator.get();
  CategoryProductBloc() : super(CategoryProductInitial()) {
    on<CategoryProductInitialized>((event, emit) async {
      emit(CategoryProductLoading());

      var productListByCategory = await categoryProductRepository
          .getProductsByCategoryId(event.categoryId);

      emit(CategoryProductSuccess(productListByCategory));
    });
  }
}
