import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'health_record_model.g.dart';

@HiveType(typeId: 2)
class HealthRecord extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String value;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final int iconCode;

  @HiveField(5)
  final int colorCode;

  HealthRecord({
    String? id,
    required this.title,
    required this.value,
    required this.date,
    required this.iconCode,
    required this.colorCode,
  }) : id = id ?? const Uuid().v4();
}
