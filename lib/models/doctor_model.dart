import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'doctor_model.g.dart';

@HiveType(typeId: 1)
class Doctor extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String specialty;

  @HiveField(3)
  final String contact;

  @HiveField(4)
  final String? image;

  Doctor({
    String? id,
    required this.name,
    required this.specialty,
    required this.contact,
    this.image,
  }) : id = id ?? const Uuid().v4();
}
