import 'basket_item_variant.dart';

class Product {
  String id;
  String collectionId;
  String thumbnail;
  String description;
  String popularity;
  String categoryId;
  String name;
  int price;
  int discountPrice;
  int quantity;
  num? percent;

  Product(
      this.id,
      this.collectionId,
      this.thumbnail,
      this.description,
      this.popularity,
      this.categoryId,
      this.name,
      this.price,
      this.discountPrice,
      this.quantity) {
    percent = ((price - (price + discountPrice)) / price) * 100;
  }

  factory Product.fromJson(Map<String, dynamic> jsonObject) {
    return Product(
        jsonObject['id'],
        jsonObject['collectionId'],
        'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
        jsonObject['description'],
        jsonObject['popularity'],
        jsonObject['category'],
        jsonObject['name'],
        jsonObject['price'],
        jsonObject['discount_price'],
        jsonObject['quantity']);
  }
}
