import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'medicine_model.g.dart';

@HiveType(typeId: 0)
class Medicine extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String dose;

  @HiveField(2)
  final DateTime time;

  @HiveField(3)
  final String id;

  @HiveField(4)
  final String type; // Tablet, Capsule, Syrup, Injection

  @HiveField(5)
  final String? notes;

  @HiveField(6)
  final int colorCode;

  Medicine({
    required this.name,
    required this.dose,
    required this.time,
    String? id,
    this.type = 'Tablet',
    this.notes,
    this.colorCode = 0xFF009688, // Default teal color
  }) : id = id ?? const Uuid().v4();
}
