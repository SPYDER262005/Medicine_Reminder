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

  @HiveField(7)
  final DateTime? lastTaken;

  @HiveField(8)
  final int stock; // Current quantity of pills

  @HiveField(9)
  final DateTime? expiryDate; // Medicine expiry date

  @HiveField(10)
  final List<DateTime> reminderTimes;

  @HiveField(11)
  final bool isDaily;

  @HiveField(12)
  final List<int> customDays; // 1-7 for Mon-Sun

  @HiveField(13)
  final int lowStockThreshold;

  @HiveField(14)
  final String? purpose;

  @HiveField(15)
  final String? doctorName;

  @HiveField(16)
  final bool beforeFood;

  @HiveField(17)
  final String? sideEffects;

  @HiveField(18)
  final String? warnings;

  @HiveField(19)
  final String? allergies;

  @HiveField(20)
  final String? ageGroup; // Adults, Kids, etc.

  @HiveField(21)
  final String? applyArea; // For creams

  @HiveField(22)
  final DateTime? startDate;

  @HiveField(23)
  final DateTime? endDate;

  @HiveField(24)
  final String? mealInstruction; // After Breakfast, Before Lunch, etc.

  Medicine({
    required this.name,
    required this.dose,
    required this.time,
    String? id,
    this.type = 'Tablet',
    this.notes,
    this.colorCode = 0xFF009688,
    this.lastTaken,
    this.stock = 0,
    this.expiryDate,
    List<DateTime>? reminderTimes,
    this.isDaily = true,
    List<int>? customDays,
    this.lowStockThreshold = 5,
    this.purpose,
    this.doctorName,
    this.beforeFood = false,
    this.sideEffects,
    this.warnings,
    this.allergies,
    this.ageGroup,
    this.applyArea,
    this.startDate,
    this.endDate,
    this.mealInstruction,
  }) : id = id ?? const Uuid().v4(),
       reminderTimes = reminderTimes ?? [time],
       customDays = customDays ?? [];

  bool get isTakenToday {
    if (lastTaken == null) return false;
    final now = DateTime.now();
    return lastTaken!.year == now.year &&
        lastTaken!.month == now.month &&
        lastTaken!.day == now.day;
  }

  Medicine copyWith({
    String? name,
    String? dose,
    DateTime? time,
    String? id,
    String? type,
    String? notes,
    int? colorCode,
    DateTime? lastTaken,
    int? stock,
    DateTime? expiryDate,
    List<DateTime>? reminderTimes,
    bool? isDaily,
    List<int>? customDays,
    int? lowStockThreshold,
    String? purpose,
    String? doctorName,
    bool? beforeFood,
    String? sideEffects,
    String? warnings,
    String? allergies,
    String? ageGroup,
    String? applyArea,
    DateTime? startDate,
    DateTime? endDate,
    String? mealInstruction,
  }) {
    return Medicine(
      name: name ?? this.name,
      dose: dose ?? this.dose,
      time: time ?? this.time,
      id: id ?? this.id,
      type: type ?? this.type,
      notes: notes ?? this.notes,
      colorCode: colorCode ?? this.colorCode,
      lastTaken: lastTaken ?? this.lastTaken,
      stock: stock ?? this.stock,
      expiryDate: expiryDate ?? this.expiryDate,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      isDaily: isDaily ?? this.isDaily,
      customDays: customDays ?? this.customDays,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      purpose: purpose ?? this.purpose,
      doctorName: doctorName ?? this.doctorName,
      beforeFood: beforeFood ?? this.beforeFood,
      sideEffects: sideEffects ?? this.sideEffects,
      warnings: warnings ?? this.warnings,
      allergies: allergies ?? this.allergies,
      ageGroup: ageGroup ?? this.ageGroup,
      applyArea: applyArea ?? this.applyArea,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      mealInstruction: mealInstruction ?? this.mealInstruction,
    );
  }
}
