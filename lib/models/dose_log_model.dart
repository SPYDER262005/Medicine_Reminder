import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'dose_log_model.g.dart';

@HiveType(typeId: 3)
class DoseLog extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String medicineId;

  @HiveField(2)
  final String medicineName;

  @HiveField(3)
  final DateTime scheduledTime;

  @HiveField(4)
  final DateTime? actualTime;

  @HiveField(5)
  final bool isTaken; // true if taken, false if missed/skipped

  @HiveField(6)
  final String? note;

  DoseLog({
    String? id,
    required this.medicineId,
    required this.medicineName,
    required this.scheduledTime,
    this.actualTime,
    required this.isTaken,
    this.note,
  }) : id = id ?? const Uuid().v4();
}
