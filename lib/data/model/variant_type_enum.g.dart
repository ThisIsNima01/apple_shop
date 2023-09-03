// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VariantTypeEnumAdapter extends TypeAdapter<VariantTypeEnum> {
  @override
  final int typeId = 3;

  @override
  VariantTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VariantTypeEnum.COLOR;
      case 1:
        return VariantTypeEnum.STORAGTE;
      case 2:
        return VariantTypeEnum.VOLTAGE;
      default:
        return VariantTypeEnum.COLOR;
    }
  }

  @override
  void write(BinaryWriter writer, VariantTypeEnum obj) {
    switch (obj) {
      case VariantTypeEnum.COLOR:
        writer.writeByte(0);
        break;
      case VariantTypeEnum.STORAGTE:
        writer.writeByte(1);
        break;
      case VariantTypeEnum.VOLTAGE:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariantTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
