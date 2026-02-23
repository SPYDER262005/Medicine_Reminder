import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/dose_log_model.dart';

class HistoryProvider extends ChangeNotifier {
  List<DoseLog> logs = [];
  final box = Hive.box<DoseLog>('dose_logs');

  HistoryProvider() {
    loadLogs();
  }

  void loadLogs() {
    logs = box.values.toList();
    logs.sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));
    notifyListeners();
  }

  void addLog(DoseLog log) {
    box.add(log);
    logs.insert(0, log);
    notifyListeners();
  }

  void updateLog(String id, DoseLog updatedLog) {
    final index = logs.indexWhere((l) => l.id == id);
    if (index != -1) {
      final key = logs[index].key;
      box.put(key, updatedLog);
      logs[index] = updatedLog;
      notifyListeners();
    }
  }

  List<DoseLog> getLogsForMedicine(String medicineId) {
    return logs.where((l) => l.medicineId == medicineId).toList();
  }

  Map<DateTime, List<DoseLog>> getLogsByDate() {
    final Map<DateTime, List<DoseLog>> grouped = {};
    for (final log in logs) {
      final date = DateTime(log.scheduledTime.year, log.scheduledTime.month, log.scheduledTime.day);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(log);
    }
    return grouped;
  }
}
