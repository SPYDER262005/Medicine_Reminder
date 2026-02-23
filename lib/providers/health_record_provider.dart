import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/health_record_model.dart';

class HealthRecordProvider extends ChangeNotifier {
  List<HealthRecord> records = [];
  final box = Hive.box<HealthRecord>('health_records');

  HealthRecordProvider() {
    loadRecords();
  }

  void loadRecords() {
    records = box.values.toList();
    records.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  void addRecord(HealthRecord record) {
    box.add(record);
    records.insert(0, record);
    notifyListeners();
  }

  void deleteRecord(String id) {
    final index = records.indexWhere((r) => r.id == id);
    if (index != -1) {
      records[index].delete();
      records.removeAt(index);
      notifyListeners();
    }
  }
}
