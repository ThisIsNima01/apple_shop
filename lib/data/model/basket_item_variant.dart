import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:hive/hive.dart';

part 'basket_item_variant.g.dart';
@HiveType(typeId: 1)
class BasketItemVariant {
  @HiveField(0)
  VariantType variantType;
  @HiveField(1)
  Variant variant;

  BasketItemVariant(this.variantType, this.variant);
}
