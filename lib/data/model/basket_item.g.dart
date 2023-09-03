// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasketItemAdapter extends TypeAdapter<BasketItem> {
  @override
  final int typeId = 0;

  @override
  BasketItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasketItem(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as int,
      fields[6] as int,
      basketItemVariantList: (fields[8] as List).cast<BasketItemVariant>(),
    )
      ..percent = fields[7] as num?
      ..quantity = fields[9] as int;
  }

  @override
  void write(BinaryWriter writer, BasketItem obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.collectionId)
      ..writeByte(2)
      ..write(obj.thumbnail)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.discountPrice)
      ..writeByte(7)
      ..write(obj.percent)
      ..writeByte(8)
      ..write(obj.basketItemVariantList)
      ..writeByte(9)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
