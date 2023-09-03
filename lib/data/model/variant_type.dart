import 'package:apple_shop/data/model/variant_type_enum.dart';
import 'package:hive/hive.dart';

part 'variant_type.g.dart';
@HiveType(typeId: 2)
class VariantType {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? title;
  @HiveField(3)
  VariantTypeEnum? type;

  VariantType(this.id, this.name, this.title, this.type);

  factory VariantType.fromJson(Map<String, dynamic> jsonObject) {
    return VariantType(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['title'],
      _getVariantTypeEnum(jsonObject['type']),
    );
  }
}

VariantTypeEnum _getVariantTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.COLOR;
    case 'Storage':
      return VariantTypeEnum.STORAGTE;
    case 'Voltage':
      return VariantTypeEnum.VOLTAGE;
    default:
      return VariantTypeEnum.COLOR;
  }
}


