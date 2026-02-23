import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 4)
class Appointment extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String doctorId;

  @HiveField(2)
  final String doctorName;

  @HiveField(3)
  final String specialty;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final String? note;

  Appointment({
    String? id,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.date,
    this.note,
  }) : id = id ?? const Uuid().v4();
}
