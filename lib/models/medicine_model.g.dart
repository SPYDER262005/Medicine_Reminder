// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineAdapter extends TypeAdapter<Medicine> {
  @override
  final int typeId = 0;

  @override
  Medicine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Medicine(
      name: fields[0] as String,
      dose: fields[1] as String,
      time: fields[2] as DateTime,
      id: fields[3] as String?,
      type: fields[4] as String,
      notes: fields[5] as String?,
      colorCode: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Medicine obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dose)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.colorCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
