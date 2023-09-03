// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VariantTypeAdapter extends TypeAdapter<VariantType> {
  @override
  final int typeId = 2;

  @override
  VariantType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VariantType(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as VariantTypeEnum?,
    );
  }

  @override
  void write(BinaryWriter writer, VariantType obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariantTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
