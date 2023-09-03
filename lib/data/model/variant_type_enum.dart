import 'package:hive/hive.dart';

part 'variant_type_enum.g.dart';
@HiveType(typeId: 3)
enum VariantTypeEnum {
  @HiveField(0)
  COLOR,
  @HiveField(1)
  STORAGTE,
  @HiveField(2)
  VOLTAGE,
}