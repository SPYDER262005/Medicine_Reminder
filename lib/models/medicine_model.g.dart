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
      lastTaken: fields[7] as DateTime?,
      stock: fields[8] as int,
      expiryDate: fields[9] as DateTime?,
      reminderTimes: (fields[10] as List?)?.cast<DateTime>(),
      isDaily: fields[11] as bool,
      customDays: (fields[12] as List?)?.cast<int>(),
      lowStockThreshold: fields[13] as int,
      purpose: fields[14] as String?,
      doctorName: fields[15] as String?,
      beforeFood: fields[16] as bool,
      sideEffects: fields[17] as String?,
      warnings: fields[18] as String?,
      allergies: fields[19] as String?,
      ageGroup: fields[20] as String?,
      applyArea: fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Medicine obj) {
    writer
      ..writeByte(22)
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
      ..write(obj.colorCode)
      ..writeByte(7)
      ..write(obj.lastTaken)
      ..writeByte(8)
      ..write(obj.stock)
      ..writeByte(9)
      ..write(obj.expiryDate)
      ..writeByte(10)
      ..write(obj.reminderTimes)
      ..writeByte(11)
      ..write(obj.isDaily)
      ..writeByte(12)
      ..write(obj.customDays)
      ..writeByte(13)
      ..write(obj.lowStockThreshold)
      ..writeByte(14)
      ..write(obj.purpose)
      ..writeByte(15)
      ..write(obj.doctorName)
      ..writeByte(16)
      ..write(obj.beforeFood)
      ..writeByte(17)
      ..write(obj.sideEffects)
      ..writeByte(18)
      ..write(obj.warnings)
      ..writeByte(19)
      ..write(obj.allergies)
      ..writeByte(20)
      ..write(obj.ageGroup)
      ..writeByte(21)
      ..write(obj.applyArea);
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
