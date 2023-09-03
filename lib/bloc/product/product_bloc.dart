import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';

import '../../data/model/basket_item.dart';
import '../../data/repository/basket_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _productDetailRepository = locator.get();
  final IBasketRepository _basketRepository = locator.get();

  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializeEvent>(
      (event, emit) async {
        emit(ProductDetailLoadingState());
        var productImages =
            await _productDetailRepository.getProductImage(event.productId);
        var productVariants =
            await _productDetailRepository.getProductVariants(event.productId);
        var productCategory =
            await _productDetailRepository.getProductCategory(event.categoryId);

        var productProperties = await _productDetailRepository
            .getProductProperties(event.productId);

        emit(ProductDetailResponseState(productImages, productVariants,
            productCategory, productProperties));
      },
    );

    on<ProductAddedToBasket>(
      (event, emit) async {
        // final basketItem = BasketItem(
        //     event.product.id,
        //     event.product.collectionId,
        //     event.product.thumbnail,
        //     event.product.categoryId,
        //     event.product.name,
        //     event.product.price,
        //     event.product.price + event.product.discountPrice,event.product.basketItemVariantList!);

        _basketRepository.addProductToBasket(event.product);
      },
    );
  }
}
