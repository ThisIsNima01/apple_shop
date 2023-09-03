import 'package:apple_shop/data/model/basket_item_variant.dart';
import 'package:hive/hive.dart';

part 'basket_item.g.dart';

@HiveType(typeId: 0)
class BasketItem extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  String categoryId;
  @HiveField(4)
  String name;
  @HiveField(5)
  int price;
  @HiveField(6)
  int discountPrice;
  @HiveField(7)
  num? percent;
  @HiveField(8)
  List<BasketItemVariant> basketItemVariantList;
  @HiveField(9)
  int quantity = 1;

  bool isSameItem(BasketItem basketItem) {
    if (basketItem.basketItemVariantList.length == 1) {
      return (basketItem.id == id &&
          (basketItem.basketItemVariantList[0].variant.value ==
              basketItemVariantList[0].variant.value));
    } else if (basketItem.basketItemVariantList.length == 2) {
      return (basketItem.id == id &&
          ((basketItem.basketItemVariantList[0].variant.value ==
                  basketItemVariantList[0].variant.value &&
              (basketItem.basketItemVariantList[1].variant.value ==
                  basketItemVariantList[1].variant.value))));
    } else if (basketItem.basketItemVariantList.isEmpty){
      return basketItem.id == id;
    }
    return false;
  }

  BasketItem(this.id, this.collectionId, this.thumbnail, this.categoryId,
      this.name, this.price, this.discountPrice,
      {required this.basketItemVariantList}) {
    discountPrice = discountPrice * quantity;
    percent = ((price - (discountPrice)) / price) * 100;
    // thumbnail =         'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}';
  }
}
