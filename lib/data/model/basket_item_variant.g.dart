// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_item_variant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasketItemVariantAdapter extends TypeAdapter<BasketItemVariant> {
  @override
  final int typeId = 1;

  @override
  BasketItemVariant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasketItemVariant(
      fields[0] as VariantType,
      fields[1] as Variant,
    );
  }

  @override
  void write(BinaryWriter writer, BasketItemVariant obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.variantType)
      ..writeByte(1)
      ..write(obj.variant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketItemVariantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
