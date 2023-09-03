import 'package:hive/hive.dart';

part 'variant.g.dart';
@HiveType(typeId: 4)
class Variant {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? typeId;
  @HiveField(3)
  String? value;
  @HiveField(4)
  int? priceChange;

  Variant(this.id, this.name, this.typeId, this.value, this.priceChange);

  factory Variant.fromJson(Map<String, dynamic> jsonObject) => Variant(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['type_id'],
      jsonObject['value'],
      jsonObject['price_change']);
}
